import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/data/remote_user.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/utils/flavor_util.dart';
import 'package:konfiso/shared/utils/time_util.dart';

final authDatabaseRemoteProvider = Provider(
  (Ref ref) => AuthDatabaseRemote(
    ref.read(httpClientProvider),
    ref.read(flavorUtilProvider),
    ref.read(timeUtilProvider),
  ),
);

class AuthDatabaseRemote {
  AuthDatabaseRemote(this._httpClient, this._flavorUtil, this._timeUtil) {
    dbUrl = '${_flavorUtil.currentConfig.values.firebaseDBUrl}users';
  }

  final HttpClient _httpClient;
  final FlavorUtil _flavorUtil;
  final TimeUtil _timeUtil;
  late String dbUrl;

  Future<void> saveUser(String authId, String email, String privacyPolicy) async {
    final user = RemoteUser(authId: authId, consented: true, consentUrl: privacyPolicy);

    final url = '$dbUrl.json';
    final data = json.encode(user.toJson());

    await _httpClient.post(url: url, data: data);
  }

  Future<dynamic> fetchUserIdByAuthId(String authId) async {
    final queryUrl = '$dbUrl.json?orderBy="authId"&equalTo="$authId"';
    final response = await _httpClient.get(url: queryUrl);

    final userId = response.data.keys.first;
    return userId;
  }
}
