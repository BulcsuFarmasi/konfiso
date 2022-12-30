import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/list_books_response_payload.dart';
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

  BookService(this._bookGoogleRemote, this._bookDatabaseRemote, this._bookMolyRemote, this._authService);

  Future<List<Volume>> search(String searchTerm) async {
    List<Volume> volumes = [];
    try {
      final response = await _bookGoogleRemote.search(searchTerm);
      final payload = ListBooksResponsePayload.fromJson(response.data);
      if (payload.totalItems != 0) {
        volumes = payload.items!;
      }
      return volumes;
    } on DioError catch (_) {
      throw NetworkException();
    }
  }

  Future<ListBooksResponsePayload> loadBookByIsbn(String isbn) async {
    try {
      final response = await _bookGoogleRemote.loadBookByIsbn(isbn);
      return ListBooksResponsePayload.fromJson(response.data);
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

  Stream<VolumeCategoryLoading> loadBooksByReadingStatus(BookReadingStatus bookReadingStatus) async* {
    try {
      final bookIds = await _bookDatabaseRemote.loadIdsByReadingStatus(bookReadingStatus, _authService.user!.userId!);

      final totalBookNumber = bookIds?.length ?? 0;
      int currentBookNumber = 0;
      VolumeCategoryLoading volumeCategoryLoading = VolumeCategoryLoading([], currentBookNumber, totalBookNumber);
      yield volumeCategoryLoading;
      if (totalBookNumber != 0) {
        currentBookNumber = 1;
        for (; currentBookNumber <= totalBookNumber; currentBookNumber++) {
          final isbn = await _bookDatabaseRemote.loadIsbnById(bookIds![currentBookNumber - 1]);

          final response = await _bookGoogleRemote.loadBookByIsbn(isbn);
          final volume = ListBooksResponsePayload.fromJson(response.data).items?.first;

          if (volume != null) {
            volumeCategoryLoading = volumeCategoryLoading
                .copyWith(currentVolumeNumber: currentBookNumber, volumes: [...volumeCategoryLoading.volumes, volume]);
            yield volumeCategoryLoading;
          }
        }
      }
    } catch (_) {
      throw NetworkException();
    }
  }

  void deleteBookByIsbn(String isbn) async {
    final bookId = await _bookDatabaseRemote.loadBookIdbyIsbn(isbn);

    if (bookId != null) {
      _bookDatabaseRemote.deleteBookReadingDetail(bookId, _authService.user!.userId!);
    }
  }
}
