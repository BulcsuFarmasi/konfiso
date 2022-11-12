import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/http_client.dart';

final bookRemoteProvider =
    Provider((Ref ref) => BookRemote(ref.read(httpClientProvider)));

class BookRemote {
  final HttpClient _httpClient;

  static const apiUrl = 'https://www.googleapis.com/books/v1/volumes';

  BookRemote(this._httpClient);

  Future<Response> search(String searchTerm) async {
    searchTerm = searchTerm.trim().replaceAll(' ', '+');
    final url = '$apiUrl?q="$searchTerm"&maxResults=10&startIndex=0';

    return _httpClient.get(url: url);
  }
}
