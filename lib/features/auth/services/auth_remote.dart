import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/model/auth_request_payload.dart';
import 'package:konfiso/features/auth/model/auth_response_payload.dart';
import 'package:konfiso/features/auth/model/refresh_token_request_payload.dart';
import 'package:konfiso/features/auth/model/refresh_token_response_payload.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/services/flavor_service.dart';

final authRemoteProvider = Provider((Ref ref) => AuthRemote(
      ref.read(httpClientProvider),
      ref.read(flavorServiceProvider),
    ));

class AuthRemote {
  final HttpClient _httpClient;
  final FlavorService _flavorService;

  static const accountUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const tokenUrl = 'https://securetoken.googleapis.com/v1/token';

  late String dbUrl;

  AuthRemote(this._httpClient, this._flavorService)
      : dbUrl =
            '${_flavorService.currentConfig.values.firebaseDBUrl}/users';

  Future<AuthResponsePayload> signIn(String email, String password) async {
    final authRequestPayload = AuthRequestPayload(email, password);
    final response = await _httpClient.post(
        url: '${accountUrl}signInWithPassword',
        data: jsonEncode(authRequestPayload.toJson()));
    return AuthResponsePayload.fromJson(response.data);
  }

  Future<void> signUp(String email, String password) async {
    final authRequestPayload = AuthRequestPayload(email, password);
    final response = await _httpClient.post(
        url: '${accountUrl}signUp',
        data: jsonEncode(authRequestPayload.toJson()));

    final authResponse = AuthResponsePayload.fromJson(response.data);
  }

  Future<RefreshTokenResponsePayload> refreshToken(String refreshToken) async {
    final refreshTokenPayload = RefreshTokenRequestPayload(refreshToken);
    final response = await _httpClient.post(
        url: tokenUrl, data: jsonEncode(refreshTokenPayload.toJson()));

    return RefreshTokenResponsePayload.fromJson(response.data);
  }
}
