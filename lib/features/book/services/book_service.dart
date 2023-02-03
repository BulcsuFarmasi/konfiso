import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/list_books_response_payload.dart';
import 'package:konfiso/features/book/data/model_book.dart';
import 'package:konfiso/features/book/data/moly_book.dart';
import 'package:konfiso/features/book/data/remote_book_reading_detail.dart';
import 'package:konfiso/features/book/data/stored_book.dart';
import 'package:konfiso/features/book/data/stored_book_reading_detail.dart';
import 'package:konfiso/features/book/data/stored_search_result.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/services/book_database_remote.dart';
import 'package:konfiso/features/book/services/book_google_remote.dart';
import 'package:konfiso/features/book/services/book_moly_remote.dart';
import 'package:konfiso/features/book/services/book_reading_storage.dart';
import 'package:konfiso/features/book/services/book_search_storage.dart';
import 'package:konfiso/features/book/services/book_selected_storage.dart';
import 'package:konfiso/shared/capabiliities/isbn_from_industry_ids_capability.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final bookServiceProvider = Provider(
  (ref) => BookService(
    ref.read(bookGoogleRemoteProvider),
    ref.read(bookDatabaseRemoteProvider),
    ref.read(bookMolyRemoteProvider),
    ref.read(bookReadingStorageProvider),
    ref.read(bookSearchStorageProvider),
    ref.read(bookSelectedStorageProvider),
    ref.read(authServiceProvider),
  ),
);

class BookService with IsbnFromIndustryIdsCapability {
  final BookGoogleRemote _bookGoogleRemote;
  final BookDatabaseRemote _bookDatabaseRemote;
  final BookMolyRemote _bookMolyRemote;
  final BookSearchStorage _bookSearchStorage;
  final BookReadingStorage _bookReadingStorage;
  final BookSelectedStorage _bookSelectedStorage;
  final AuthService _authService;

  BookService(
    this._bookGoogleRemote,
    this._bookDatabaseRemote,
    this._bookMolyRemote,
    this._bookReadingStorage,
    this._bookSearchStorage,
    this._bookSelectedStorage,
    this._authService,
  );

  Future<List<ModelBook>> search(String searchTerm) async {
    List<Volume> volumes = [];
    List<MolyBook> molyBooks = [];

    bool googleRequestFailed = false;
    bool molyRequestFailed = false;
    Response? response;
    try {
      response = await _bookGoogleRemote.search(searchTerm);
    } on DioError catch (_) {
      googleRequestFailed = true;
    }
    if (response != null) {
      final payload = ListBooksResponsePayload.fromJson(response.data);
      if (payload.totalItems != 0) {
        volumes = payload.items!;
      }
    }

    try {
      molyBooks = await _bookMolyRemote.search(searchTerm);
    } on DioError catch (_) {
      molyRequestFailed = true;
    }

    if (googleRequestFailed && molyRequestFailed) {
      throw NetworkException();
    }
    return [...volumes, ...molyBooks];
  }

  Future<StoredSearchResult?> loadSearchResult(String searchTerm) async {
    return _bookSearchStorage.loadSearchResult(searchTerm);
  }

  void saveSearchResult(StoredSearchResult storedSearchResult) {
    _bookSearchStorage.saveSearchResult(storedSearchResult);
  }

  Future<void> loadBookFromSearchResult(
      Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType, String searchTerm) async {
    final selectedBookReadingDetail = await _bookSearchStorage.loadStoredBook(industryIdsByType, searchTerm);
    if (selectedBookReadingDetail != null) {
      await _bookSelectedStorage.saveSelectedBook(selectedBookReadingDetail);
    }
  }

  Future<void> loadBookFromBookReadings(String isbn) async {
    final selectedBook = await _bookReadingStorage.loadStoredBook(isbn);
    await _bookSelectedStorage.saveSelectedBook(selectedBook);
  }

  Future<Volume?> loadBookByIsbnFromRemote(String isbn) async {
    try {
      final listBookResponse = await _bookGoogleRemote.loadBookByIsbn(isbn);

      ListBooksResponsePayload listBooksResponsePayload = ListBooksResponsePayload.fromJson(listBookResponse.data);

      Volume? volume;

      if (listBooksResponsePayload.totalItems != 0) {
        volume = listBooksResponsePayload.items?.first;
      }

      if (!_isVolumeComplete(volume)) {
        final molyBook = await _bookMolyRemote.loadBookByIsbn(isbn);

        volume = Volume(
            volume?.id ?? '',
            VolumeInfo(
              title: volume?.volumeInfo.title ?? molyBook?.title ?? '',
              authors: volume?.volumeInfo.authors ?? molyBook?.author.split(' - '),
              publishedDate: volume?.volumeInfo.publishedDate ?? molyBook?.year.toString(),
              industryIdentifiers:
                  volume?.volumeInfo.industryIdentifiers ?? _convertMolyIsbnToIndustryIdentifiers(molyBook?.isbn),
              imageLinks: volume?.volumeInfo.imageLinks ??
                  ImageLinks(thumbnail: molyBook?.cover?.replaceAll('/normal/', '/big/')),
            ));
      }

      return volume;
    } on DioError {
      throw NetworkException();
    }
  }

  Future<RemoteBookReadingDetail?> loadBookReadingDetailByIsbnFromRemote(String isbn) async {
    String? bookId = await _bookDatabaseRemote.loadBookIdbyIsbn(isbn);

    bookId ??= '';

    final bookReadingDetailResponse = await _bookDatabaseRemote.loadBookReadingDetailById(bookId, _authService.user!);

    return RemoteBookReadingDetail.fromJson(bookReadingDetailResponse?.data ?? {});
  }

  Future<StoredBookReadingDetail?> loadSelectedBook() async {
    return _bookSelectedStorage.loadSelectedBook();
  }

  Future<RemoteBookReadingDetail?> loadBookReadingDetailByIsbn(String isbn) async {
    final bookId = await _bookDatabaseRemote.loadBookIdbyIsbn(isbn);

    if (bookId == null) {
      return null;
    }

    Response? response;

    try {
      response = await _bookDatabaseRemote.loadBookReadingDetailById(bookId, _authService.user!);
    } on DioError {
      throw NetworkException();
    }

    return (response != null) ? RemoteBookReadingDetail.fromJson(response.data) : null;
  }

  Future<void> saveBook(BookReadingDetail bookReadingDetail) async {
    await _saveBookToDatabase(bookReadingDetail);
    await saveBookToStorage(bookReadingDetail);
  }

  Future<void> saveBookToStorage(BookReadingDetail bookReadingDetail) async {
    final storedBookReadingDetail = StoredBookReadingDetail(
      StoredBook(
        title: bookReadingDetail.book!.title,
        authors: bookReadingDetail.book!.authors,
        publicationYear: bookReadingDetail.book!.publicationYear,
        industryIdsByType: bookReadingDetail.book!.industryIdsByType,
        coverImage: StoredCoverImage(
          smallest: bookReadingDetail.book!.coverImage?.smallest,
          smaller: bookReadingDetail.book!.coverImage?.smaller,
          small: bookReadingDetail.book!.coverImage?.small,
          large: bookReadingDetail.book!.coverImage?.large,
          larger: bookReadingDetail.book!.coverImage?.larger,
          largest: bookReadingDetail.book!.coverImage?.largest,
        ),
        validUntil: DateTime.now().add(const Duration(days: 3)),
      ),
      bookReadingDetail.status,
      bookReadingDetail.currentPage,
      bookReadingDetail.rating,
      bookReadingDetail.comment,
    );

    _bookReadingStorage.saveBookReading(storedBookReadingDetail);
  }

  Future<List<StoredBook>> loadBooksByReadingStatusFromStorage(BookReadingStatus bookReadingStatus) async {
    final bookReadingDetails = await _bookReadingStorage.loadBookReadingDetails(bookReadingStatus);

    return bookReadingDetails
        .map((StoredBookReadingDetail storedBookReadingDetail) => storedBookReadingDetail.book)
        .toList();
  }

  Future<List<String>> loadIsbnByReadingStatusFromRemote(BookReadingStatus bookReadingStatus) async {
    final isbns = <String>[];

    final bookIds = await _bookDatabaseRemote.loadIdsByReadingStatus(bookReadingStatus, _authService.user!);

    if (bookIds == null) {
      return isbns;
    }

    for (String bookId in bookIds) {
      final isbn = await _bookDatabaseRemote.loadIsbnById(bookId);
      isbns.add(isbn);
    }

    return isbns;
  }

  void deleteBookByIsbn(String isbn) async {
    deleteBookByIsbn(isbn);

    final bookId = await _bookDatabaseRemote.loadBookIdbyIsbn(isbn);

    if (bookId != null) {
      _bookDatabaseRemote.deleteBookReadingDetail(bookId, _authService.user!);
    }
  }

  void deleteBookFromStorage(String isbn) async {
    await _bookReadingStorage.deleteBook(isbn);
  }

  Future<void> _saveBookToDatabase(BookReadingDetail bookReadingDetail) async {
    try {
      final remoteBookReadingDetail = RemoteBookReadingDetail(
        status: bookReadingDetail.status,
        authId: _authService.user!.authId,
        currentPage: bookReadingDetail.currentPage,
        rating: bookReadingDetail.rating,
        comment: bookReadingDetail.comment,
      );

      final isbn = getIsbnFromIndustryIds(bookReadingDetail.book!.industryIdsByType!);

      String? bookId = await _bookDatabaseRemote.loadBookIdbyIsbn(isbn);

      bookId ??= await _bookDatabaseRemote.insertBook(isbn);

      await _bookDatabaseRemote.deleteBookReadingDetail(bookId, _authService.user!);

      await _bookDatabaseRemote.insertBookReadingDetail(bookId, _authService.user!, remoteBookReadingDetail);
    } on DioError catch (_) {
      throw NetworkException();
    }
  }

  bool _isVolumeComplete(Volume? volume) {
    return volume != null &&
        volume.volumeInfo.authors != null &&
        volume.volumeInfo.publishedDate != null &&
        volume.volumeInfo.industryIdentifiers != null &&
        volume.volumeInfo.imageLinks?.small != null &&
        volume.volumeInfo.imageLinks?.thumbnail == null;
  }

  List<VolumeIndustryIdentifier>? _convertMolyIsbnToIndustryIdentifiers(String? molyIsbn) {
    if (molyIsbn == null) {
      return null;
    } else if (molyIsbn.length == 13) {
      return [VolumeIndustryIdentifier('ISBN_13', molyIsbn)];
    } else if (molyIsbn.length == 10) {
      return [VolumeIndustryIdentifier('ISBN_10', molyIsbn)];
    } else {
      return null;
    }
  }
}
