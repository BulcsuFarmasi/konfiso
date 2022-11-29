import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/list_books_response_payload.dart';
import 'package:konfiso/features/book/data/volume.dart';
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
      final payload = ListBooksResponsePayload.fromJson(response.data);
      if (payload.totalItems != 0) {
        volumes = payload.items!;
      }
      return volumes;
    } on DioError catch (e) {
      throw NetworkException(e.message);
    }
  }

  Future<Volume> loadBookByExternalId(String externalId) async {
    final response = await _bookRemote.loadBookByExternalId(externalId);
    return Volume.fromJson(response.data);
  }
}
