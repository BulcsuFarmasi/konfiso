import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/model/volume.dart';
import 'package:konfiso/shared/http_client.dart';

final bookRemoteProvider =
    Provider((Ref ref) => BookRemote(ref.read(httpClientProvider)));

class BookRemote {
  final HttpClient _httpClient;

  static const apiUrl = 'https://www.googleapis.com/books/v1/volumes';

  BookRemote(this._httpClient);

  Future<List<Volume>> search(String searchTerm) async {
    searchTerm = searchTerm.replaceAll(' ', '+');
    final url = '$apiUrl?q=$searchTerm';
    print(url);
    final response =
        await _httpClient.get(url: url);
    print(response.data);

    return [
      Volume('', VolumeInfo('', [''], ImageLinks('x')))
    ];
  }
}
