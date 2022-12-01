import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/list_books_response_payload.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/data/volume_category_loading.dart';
import 'package:konfiso/features/book/services/book_remote.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final bookServiceProvider = Provider((ref) => BookService(ref.read(bookRemoteProvider), ref.read(authServiceProvider)));

class BookService {
  final BookRemote _bookRemote;
  final AuthService _authService;

  BookService(this._bookRemote, this._authService);

  Future<List<Volume>> search(String searchTerm) async {
    List<Volume> volumes = [];
    try {
      final response = await _bookRemote.search(searchTerm);
      final payload = ListBooksResponsePayload.fromJson(response.data);
      if (payload.totalItems != 0) {
        volumes = payload.items!;
      }
      return volumes;
    } on DioError catch (_) {
      throw NetworkException();
    }
  }

  Future<Volume> loadBookByIsbn(String isbn) async {
    try {
      final response = await _bookRemote.loadBookByIsbn(isbn);
      return ListBooksResponsePayload.fromJson(response.data).items!.first;
    } on DioError catch (_) {
      throw NetworkException();
    }
  }

  Future<void> saveBook(String isbn, BookReadingDetail bookReadingDetail) async {
    try {
      String? bookId = await _bookRemote.loadBookIdbyIsbn(isbn);

      bookId ??= await _bookRemote.insertBook(isbn);

      await _bookRemote.insertBookReadingDetail(bookId, _authService.user!.userId!, bookReadingDetail);
    } on DioError catch (_) {
      throw NetworkException();
    }
  }

  Stream<VolumeCategoryLoading> loadBooksByReadingStatus(BookReadingStatus bookReadingStatus) async* {
    final bookIds = await _bookRemote.loadIdsByReadingStatus(bookReadingStatus, _authService.user!.userId!);

    final totalBookNumber = bookIds.length;
    int currentBookNumber = 0;
    VolumeCategoryLoading volumeCategoryLoading = VolumeCategoryLoading([], currentBookNumber, totalBookNumber);
    yield volumeCategoryLoading;

    currentBookNumber = 1;
    for (; currentBookNumber <= totalBookNumber; currentBookNumber++) {
      final isbn = await _bookRemote.loadIsbnById(bookIds[currentBookNumber - 1]);

      final volumeResponse = await _bookRemote.loadBookByIsbn(isbn);
      final volume = Volume.fromJson(volumeResponse.data);

      volumeCategoryLoading = volumeCategoryLoading
          .copyWith(currentVolumeNumber: currentBookNumber, volumes: [...volumeCategoryLoading.volumes, volume]);
      yield volumeCategoryLoading;
    }
  }
}
