import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/model/book_response_payload.dart';
import 'package:konfiso/features/book/model/volume.dart';
import 'package:konfiso/features/book/services/book_remote.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final bookServiceProvider =
    Provider((ref) => BookService(ref.read(bookRemoteProvider)));

class BookService {
  final BookRemote _bookRemote;

  BookService(this._bookRemote);

  Future<List<Volume>> search(String searchTerm) async {
    List<Volume> volumes = [];
    try {
      final response = await _bookRemote.search(searchTerm);
      final payload = BookResponsePayload.fromJson(response.data);
      if (payload.totalItems != 0) {
        volumes = payload.items!;
      }
    } on DioError catch (e) {
      NetworkException(e.message);
    }
    return volumes;
  }
}