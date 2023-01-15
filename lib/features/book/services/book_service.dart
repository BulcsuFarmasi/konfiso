import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/book/data/model_book.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/list_books_response_payload.dart';
import 'package:konfiso/features/book/data/moly_book.dart';
import 'package:konfiso/features/book/data/remote_book_reading_detail.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/data/volume_category_loading.dart';
import 'package:konfiso/features/book/services/book_database_remote.dart';
import 'package:konfiso/features/book/services/book_google_remote.dart';
import 'package:konfiso/features/book/services/book_moly_remote.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final bookServiceProvider = Provider(
  (ref) => BookService(
    ref.read(bookGoogleRemoteProvider),
    ref.read(bookDatabaseRemote),
    ref.read(bookMolyRemoteProvider),
    ref.read(authServiceProvider),
  ),
);

class BookService {
  final BookGoogleRemote _bookGoogleRemote;
  final BookDatabaseRemote _bookDatabaseRemote;
  final BookMolyRemote _bookMolyRemote;
  final AuthService _authService;

  final StreamController<VolumeCategoryLoading> _watchVolumeCategoryLoadingController =
      StreamController<VolumeCategoryLoading>.broadcast();

  Stream<VolumeCategoryLoading> get watchVolumeCategoryLoading => _watchVolumeCategoryLoadingController.stream;

  BookService(this._bookGoogleRemote, this._bookDatabaseRemote, this._bookMolyRemote, this._authService);

  Future<List<ModelsBook>> search(String searchTerm) async {
    List<Volume> volumes = [];
    try {
      final response = await _bookGoogleRemote.search(searchTerm);
      final payload = ListBooksResponsePayload.fromJson(response.data);
      if (payload.totalItems != 0) {
        volumes = payload.items!;
      }
      final molyBooks = await _bookMolyRemote.search(searchTerm);
      return [...volumes, ...molyBooks];
    } on DioError catch (_) {
      throw NetworkException();
    }
  }

  Stream<Volume?> loadBookByIsbn(String isbn) async* {
    try {
      Volume? volume;
      final response = await _bookGoogleRemote.loadBookByIsbn(isbn);
      final listBookResponse = ListBooksResponsePayload.fromJson(response.data);

      if (listBookResponse.totalItems != 0) {
        volume = listBookResponse.items?.first;
        yield volume;
      }

      if (listBookResponse.totalItems == 0 || !_isVolumeComplete(listBookResponse.items?.first)) {
        final molyBook = await _bookMolyRemote.loadBookByIsbn(isbn);

        final industryIdentifiers = _convertMolyIsbnToIndustryIdentifiers(isbn);

        volume = Volume(
          volume?.id ?? '',
          VolumeInfo(
            title: volume?.volumeInfo.title ?? molyBook?.title ?? '',
            authors: volume?.volumeInfo.authors ?? molyBook?.author.split(' - '),
            publishedDate: volume?.volumeInfo.publishedDate ?? molyBook?.year.toString(),
            industryIdentifiers: volume?.volumeInfo.industryIdentifiers ?? industryIdentifiers,
            imageLinks: volume?.volumeInfo.imageLinks?.small != null
                ? volume?.volumeInfo.imageLinks
                : ImageLinks(
                    small: molyBook?.cover?.replaceAll('/normal/', '/big/'),
                  ),
          ),
        );
      }

      yield volume;
    } on DioError catch (_) {
      throw NetworkException();
    }
  }

  Future<RemoteBookReadingDetail?> loadBookReadingDetailByIsbn(String isbn) async {
    final bookId = await _bookDatabaseRemote.loadBookIdbyIsbn(isbn);

    if (bookId == null) {
      return null;
    }

    final response = await _bookDatabaseRemote.loadBookReadingDetailById(bookId, _authService.user!.userId!);

    return (response != null) ? RemoteBookReadingDetail.fromJson(response.data) : null;
  }

  Future<void> saveBook(String isbn, RemoteBookReadingDetail bookReadingDetail) async {
    try {
      String? bookId = await _bookDatabaseRemote.loadBookIdbyIsbn(isbn);

      bookId ??= await _bookDatabaseRemote.insertBook(isbn);

      await _bookDatabaseRemote.deleteBookReadingDetail(bookId, _authService.user!.userId!);

      await _bookDatabaseRemote.insertBookReadingDetail(bookId, _authService.user!.userId!, bookReadingDetail);
    } on DioError catch (_) {
      throw NetworkException();
    }
  }

  Future<void> loadBooksByReadingStatus(BookReadingStatus bookReadingStatus) async {
    try {
      final bookIds = await _bookDatabaseRemote.loadIdsByReadingStatus(bookReadingStatus, _authService.user!.userId!);

      final totalBookNumber = bookIds?.length ?? 0;
      int currentBookNumber = 0;
      VolumeCategoryLoading volumeCategoryLoading = VolumeCategoryLoading(currentBookNumber, totalBookNumber);
      _watchVolumeCategoryLoadingController.add(volumeCategoryLoading);

      if (totalBookNumber != 0) {
        currentBookNumber = 1;
        while (currentBookNumber <= totalBookNumber) {
          final isbn = await _bookDatabaseRemote.loadIsbnById(bookIds![currentBookNumber - 1]);

          final response = await _bookGoogleRemote.loadBookByIsbn(isbn);
          Volume? volume = ListBooksResponsePayload.fromJson(response.data).items?.first;

          if (volume != null) {
            volume = volume.copyWith(volumeIndex: currentBookNumber - 1);
            volumeCategoryLoading = volumeCategoryLoading.copyWith(
              currentVolumeNumber: currentBookNumber,
              currentVolume: volume,
            );
            _watchVolumeCategoryLoadingController.add(volumeCategoryLoading);
          }

          if (volume == null || !_isVolumeComplete(volume)) {
            _bookMolyRemote.loadBookByIsbn(isbn).then((MolyBook? molyBook) {
              final industryIdentifiers = _convertMolyIsbnToIndustryIdentifiers(isbn);

              volume = Volume(
                volume?.id ?? '',
                VolumeInfo(
                  title: volume?.volumeInfo.title ?? molyBook?.title ?? '',
                  authors: volume?.volumeInfo.authors ?? molyBook?.author.split(' - '),
                  publishedDate: volume?.volumeInfo.publishedDate ?? molyBook?.year.toString(),
                  industryIdentifiers: volume?.volumeInfo.industryIdentifiers ?? industryIdentifiers,
                  imageLinks: volume?.volumeInfo.imageLinks?.thumbnail != null
                      ? volume?.volumeInfo.imageLinks
                      : ImageLinks(
                          thumbnail: molyBook?.cover?.replaceAll('/normal/', '/big/'),
                        ),
                ),
                volumeIndex: volume?.volumeIndex ?? currentBookNumber - 1,
              );

              _watchVolumeCategoryLoadingController
                  .add(volumeCategoryLoading.copyWith(currentVolume: volume, currentVolumeNumber: currentBookNumber));
            });
          }
          currentBookNumber++;
        }
      }
    } on DioError catch (_) {
      print(_);
      throw NetworkException();
    }
  }

  void deleteBookByIsbn(String isbn) async {
    final bookId = await _bookDatabaseRemote.loadBookIdbyIsbn(isbn);

    if (bookId != null) {
      _bookDatabaseRemote.deleteBookReadingDetail(bookId, _authService.user!.userId!);
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
