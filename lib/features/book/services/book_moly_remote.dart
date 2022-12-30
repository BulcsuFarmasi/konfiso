import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/http_client.dart';

final bookMolyRemoteProvider = Provider((Ref ref) => BookMolyRemote(ref.read(httpClientProvider)));

class BookMolyRemote {
  final HttpClient _httpClient;

  BookMolyRemote(this._httpClient);


}
