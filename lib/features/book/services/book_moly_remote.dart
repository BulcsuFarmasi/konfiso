import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/moly_book.dart';
import 'package:konfiso/shared/http_client.dart';

final bookMolyRemoteProvider = Provider((Ref ref) => BookMolyRemote(ref.read(httpClientProvider)));

class BookMolyRemote {
  final HttpClient _httpClient;

  static const apiUrl = 'https://moly.hu/api';

  BookMolyRemote(this._httpClient);

  Future<List<MolyBook>> search(String searchTerm) async {

    searchTerm = searchTerm.trim().replaceAll(' ', '+');
    final searchResponse = await _httpClient.get(url: '$apiUrl/books.json?q=$searchTerm');
    print(searchResponse);
    final json = jsonDecode(searchResponse.data);
    List<MolyBook> basicBooks = json['books'].map((Map<String, dynamic> jsonBook) =>
        MolyBook(id: jsonBook['id'], author: jsonBook['author'], title: jsonBook['title']));

    print(basicBooks);

    for(MolyBook book in basicBooks) {
      final editionResponse = await _httpClient.get(url: '$apiUrl//book_editions/${book.id}.json');
      print(jsonDecode(editionResponse.data));
    }



    final List<MolyBook> books = [];
    return books;
  }
}
