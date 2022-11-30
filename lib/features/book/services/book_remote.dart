import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/utils/flavor_util.dart';

final bookRemoteProvider =
    Provider((Ref ref) => BookRemote(ref.read(httpClientProvider), ref.read(flavorUtilProvider)));

class BookRemote {
  final HttpClient _httpClient;
  final FlavorUtil _flavorUtil;

  static const apiUrl = 'https://www.googleapis.com/books/v1/volumes';

  late String dbBooksUrl;
  late String dbBookReadingDetailsUrl;

  BookRemote(this._httpClient, this._flavorUtil) {
    dbBooksUrl = '${_flavorUtil.currentConfig.values.firebaseDBUrl}books';
    dbBookReadingDetailsUrl = '${_flavorUtil.currentConfig.values.firebaseDBUrl}bookReadingDetails';
  }

  Future<Response> search(String searchTerm) async {
    searchTerm = searchTerm.trim().replaceAll(' ', '+');
    final url = '$apiUrl?q="$searchTerm"&maxResults=10&startIndex=0';

    return _httpClient.get(url: url);
  }

  Future<Response> loadBookByIsbn(String isbn) async {
    final url = '$apiUrl?q=isbn:$isbn';
    return _httpClient.get(url: url);
  }

  Future<String?> loadBookIdbyIsbn(String isbn) async {
    final queryUrl = '$dbBooksUrl.json?orderBy="isbn"&equalTo="$isbn"';

    final response = await _httpClient.get(url: queryUrl);

    return (response.data.keys.isNotEmpty) ? response.data.keys.first : null;
  }

  Future<String> insertBook(String isbn) async {
    final insertUrl = '$dbBooksUrl.json';

    return (await _httpClient.post(url: insertUrl, data: jsonEncode({'isbn': isbn}))).data['name'] as String;
  }

  Future<void> insertBookReadingDetail(String bookId, String userId, BookReadingDetail bookReadingDetail) async {
    final insertUrl = '$dbBookReadingDetailsUrl/$userId/$bookId.json';

    await _httpClient.put(url: insertUrl, data: jsonEncode(bookReadingDetail.toJson()));
  }
}
