import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/model/auth_request_payload.dart';
import 'package:konfiso/features/auth/model/auth_response_payload.dart';
import 'package:konfiso/features/auth/model/refresh_token_request_payload.dart';
import 'package:konfiso/features/auth/model/refresh_token_response_payload.dart';
import 'package:konfiso/features/auth/model/remote_user.dart';
import 'package:konfiso/features/auth/model/update_user_request_payload.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/services/flavor_service.dart';
import 'package:konfiso/shared/services/time_service.dart';

final authRemoteProvider = Provider((Ref ref) =>
    AuthRemote(
      ref.read(httpClientProvider),
      ref.read(flavorServiceProvider),
      ref.read(timeServiceProvider),
    ));

class AuthRemote {
  final HttpClient _httpClient;
  final FlavorService _flavorService;
  final TimeService _timeService;

  static const accountUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const tokenUrl = 'https://securetoken.googleapis.com/v1/token';

  late String dbUrl;

  AuthRemote(this._httpClient, this._flavorService, this._timeService)
      : dbUrl = '${_flavorService.currentConfig.values.firebaseDBUrl}users';

  Future<AuthResponsePayload> signIn(String email, String password) async {
    final authRequestPayload = AuthRequestPayload(email, password);
    final response = await _httpClient.post(
        url: '${accountUrl}signInWithPassword',
        data: json.encode(authRequestPayload.toJson()));

    final authResponse = AuthResponsePayload.fromJson(response.data);

    _updateUser(authResponse.localId);

    return authResponse;
  }

  Future<void> signUp(String email, String password) async {
    final authRequestPayload = AuthRequestPayload(email, password);
    final response = await _httpClient.post(
        url: '${accountUrl}signUp',
        data: json.encode(authRequestPayload.toJson()));

    final authResponse = AuthResponsePayload.fromJson(response.data);

    _saveUser(authResponse, email);
  }

  Future<RefreshTokenResponsePayload> refreshToken(String refreshToken) async {
    final refreshTokenPayload = RefreshTokenRequestPayload(refreshToken);
    final response = await _httpClient.post(
        url: tokenUrl, data: json.encode(refreshTokenPayload.toJson()));

    return RefreshTokenResponsePayload.fromJson(response.data);
  }

  Future<void> _saveUser(AuthResponsePayload authResponsePayload,
      String email) async {
    final user = RemoteUser(
        authId: authResponsePayload.localId,
        email: email,
        registrationDate: _timeService.now(),
        consented: true,
        consentUrl: 'privacy-policy');

    final data = json.encode(user.toJson());
    print('code: $data');
    print(data.hashCode);

    await _httpClient.post(
        url: '$dbUrl.json', data: data);
  }

  Future<void> _updateUser(String authId) async {
    final queryUrl = '$dbUrl.json?orderBy="authId"&equalTo="$authId"';
    final response = await _httpClient.get(url: queryUrl);

    final userId = response.data.keys.first;

    final updateUrl = '$dbUrl/$userId.json';

    print(updateUrl);

    await _httpClient.patch(
        url: updateUrl,
        data: json.encode(UpdateUserRequestPayload(_timeService.now())));
  }
}
