import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/moly_book.dart';
import 'package:konfiso/features/book/data/moly_book_edition.dart';
import 'package:konfiso/features/book/data/moly_book_edition_response.dart';
import 'package:konfiso/features/book/data/moly_book_search_response.dart';
import 'package:konfiso/shared/http_client.dart';

final bookMolyRemoteProvider = Provider((Ref ref) => BookMolyRemote(ref.read(httpClientProvider)));

class BookMolyRemote {
  final HttpClient _httpClient;

  static const apiUrl = 'https://moly.hu/api';

  BookMolyRemote(this._httpClient);

  Future<List<MolyBook>> search(String searchTerm) async {
    searchTerm = searchTerm.trim().replaceAll(' ', '+');
    final url = '$apiUrl/books.json?q=$searchTerm';
    final response = await _httpClient.get(url: url);

    final searchResponse = MolyBookSearchResponse.fromJson(response.data);

    final Map<int, List<MolyBookEdition>> editionsByBookId = {};

    final List<MolyBook> books = [];

    // TODO optimize to O(n)

    for (MolyBook book in searchResponse.books) {
      final response = await _httpClient.get(url: '$apiUrl/book_editions/${book.id}.json');
      final editionResponse = MolyBookEditionResponse.fromJson(response.data);
      for (MolyBookEdition edition in editionResponse.editions) {
        books.add(MolyBook(
            id: book.id,
            author: book.author,
            title: book.title,
            isbn: edition.isbn,
            year: edition.year,
            cover: edition.cover));
      }
    }
    return books;
  }

  Future<MolyBook?> loadBookByIsbn(String isbn) async {
    final searchUrl = '$apiUrl/book_by_isbn.json?q=$isbn';
    print('mc');
    Response response = await _httpClient.get(url: searchUrl);
    print('md');

    if (response.data.isEmpty) {
      return null;
    }

    final selectedBook = MolyBook.fromJson(response.data);

    print('me');

    final editionsUrl = '$apiUrl/book_editions/${selectedBook.id}.json';

    print('mf');

    response = await _httpClient.get(url: editionsUrl);

    final editionsResponse = MolyBookEditionResponse.fromJson(response.data);

    final selectedEdition = editionsResponse.editions
        .firstWhere((MolyBookEdition edition) => edition.isbn == isbn, orElse: () => const MolyBookEdition());

    return MolyBook(
        id: selectedBook.id,
        author: selectedBook.author,
        title: selectedBook.title,
        isbn: selectedEdition.isbn,
        year: selectedEdition.year,
        cover: selectedEdition.cover);
  }
}
