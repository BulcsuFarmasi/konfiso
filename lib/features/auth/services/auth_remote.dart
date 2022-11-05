import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/services/auth_request_payload.dart';
import 'package:konfiso/features/auth/services/auth_response_payload.dart';
import 'package:konfiso/features/auth/services/refresh_token_request_payload.dart';
import 'package:konfiso/features/auth/services/refresh_token_response_payload.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/secret.dart';

final authRemoteProvider =
    Provider((Ref ref) => AuthRemote(ref.read(httpClientProvider)));

class AuthRemote {
  final HttpClient _httpClient;

  static const accountUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const tokenUrl = 'https://securetoken.googleapis.com/v1/token';

  AuthRemote(this._httpClient);

  Future<AuthResponsePayload> signIn(String email, String password) async {
    final authRequestPayload = AuthRequestPayload(email, password);
    final response = await _httpClient.post(
        url: '${accountUrl}signInWithPassword?key=$firebaseApiKey',
        data: jsonEncode(authRequestPayload.toJson()));
    return AuthResponsePayload.fromJson(response.data);
  }

  Future<void> signUp(String email, String password) async {
    final authRequestPayload = AuthRequestPayload(email, password);
    await _httpClient.post(
        url: '${accountUrl}signUp?key=$firebaseApiKey',
        data: jsonEncode(authRequestPayload.toJson()));
  }

  Future<RefreshTokenResponsePayload> refreshToken(String refreshToken) async {
    final refreshTokenPayload = RefreshTokenRequestPayload(refreshToken);
    final response = await _httpClient.post(
        url: '$tokenUrl?key=$firebaseApiKey',
        data: jsonEncode(refreshTokenPayload.toJson()));

    return RefreshTokenResponsePayload.fromJson(response.data);
  }
}
