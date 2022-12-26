import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/http_client.dart';

final bookGoogleRemoteProvider = Provider((Ref ref) => BookGoogleRemote(
      ref.read(httpClientProvider),
    ));

class BookGoogleRemote {
  final HttpClient _httpClient;

  static const apiUrl = 'https://www.googleapis.com/books/v1/volumes';

  BookGoogleRemote(this._httpClient);

  Future<Response> search(String searchTerm) async {
    searchTerm = searchTerm.trim().replaceAll(' ', '+');
    final url = '$apiUrl?q="$searchTerm"&maxResults=10&startIndex=0';

    return _httpClient.get(url: url);
  }

  Future<Response> loadBookByIsbn(String isbn) async {
    final url = '$apiUrl?q=isbn:$isbn';
    return _httpClient.get(url: url);
  }
}
