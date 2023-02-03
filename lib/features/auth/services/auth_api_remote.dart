import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/data/auth_request_payload.dart';
import 'package:konfiso/features/auth/data/auth_response_payload.dart';
import 'package:konfiso/features/auth/data/refresh_token_request_payload.dart';
import 'package:konfiso/features/auth/data/refresh_token_response_payload.dart';
import 'package:konfiso/features/auth/data/send_password_reset_email_request_payload.dart';
import 'package:konfiso/features/auth/data/send_verification_email_request_payload.dart';
import 'package:konfiso/features/auth/data/user_info_request_payload.dart';
import 'package:konfiso/features/auth/data/user_info_response_payload.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/services/language_service.dart';

final authApiRemoteProvider = Provider((Ref ref) => AuthApiRemote(
      ref.read(httpClientProvider),
      ref.read(languageServiceProvider),
    ));

class AuthApiRemote {
  final HttpClient _httpClient;
  final LanguageService _languageService;

  static const accountUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const tokenUrl = 'https://securetoken.googleapis.com/v1/token';

  AuthApiRemote(this._httpClient, this._languageService);

  Future<AuthResponsePayload> signIn(String email, String password) async {
    final authRequestPayload = AuthRequestPayload(email, password);
    final response =
        await _httpClient.post(url: '${accountUrl}signInWithPassword', data: json.encode(authRequestPayload.toJson()));

    final authResponse = AuthResponsePayload.fromJson(response.data);
    return authResponse;
  }

  Future<AuthResponsePayload> signUp(String email, String password) async {
    final authRequestPayload = AuthRequestPayload(email, password);
    final response = await _httpClient.post(url: '${accountUrl}signUp', data: json.encode(authRequestPayload.toJson()));

    final authResponse = AuthResponsePayload.fromJson(response.data);

    return authResponse;
  }

  Future<RefreshTokenResponsePayload> refreshToken(String refreshToken) async {
    final refreshTokenPayload = RefreshTokenRequestPayload(refreshToken);
    final response = await _httpClient.post(url: tokenUrl, data: json.encode(refreshTokenPayload.toJson()));

    return RefreshTokenResponsePayload.fromJson(response.data);
  }

  Future<UserInfoResponsePayload> loadUserInfo(String token) async {
    final requestPayload = UserInfoRequestPayload(idToken: token);

    final response = await _httpClient.post(url: '${accountUrl}lookup', data: jsonEncode(requestPayload.toJson()));

    return UserInfoResponsePayload.fromJson(response.data);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    // create payload
    final requestPayload = SendPasswordResetEmailRequestPayload(email);
    // send request
    await _httpClient.post(
      url: '${accountUrl}sendOobCode',
      data: jsonEncode(requestPayload.toJson()),
      headers: {'X-Firebase-Locale': _languageService.locale},
    );
  }

  Future<void> sendVerificationEmail(String token) async {
    const url = '${accountUrl}sendOobCode';
    final sendVerificationEmailRequestPayload = jsonEncode(SendVerificationEmailPayload(idToken: token).toJson());

    await _httpClient.post(
        url: url, data: sendVerificationEmailRequestPayload, headers: {'X-Firebase-Locale': _languageService.locale});
  }
}
