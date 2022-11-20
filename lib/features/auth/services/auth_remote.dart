import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/data/auth_request_payload.dart';
import 'package:konfiso/features/auth/data/auth_response_payload.dart';
import 'package:konfiso/features/auth/data/refresh_token_request_payload.dart';
import 'package:konfiso/features/auth/data/refresh_token_response_payload.dart';
import 'package:konfiso/features/auth/data/remote_user.dart';
import 'package:konfiso/features/auth/data/send_verification_email_request_payload.dart';
import 'package:konfiso/features/auth/data/update_user_request_payload.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/services/language_service.dart';
import 'package:konfiso/shared/utils/flavor_util.dart';
import 'package:konfiso/shared/utils/time_util.dart';

final authRemoteProvider = Provider((Ref ref) => AuthRemote(
      ref.read(httpClientProvider),
      ref.read(flavorUtilProvider),
      ref.read(timeUtilProvider),
      ref.read(languageServiceProvider),
    ));

class AuthRemote {
  final HttpClient _httpClient;
  final FlavorUtil _flavorUtil;
  final TimeUtil _timeUtil;
  final LanguageService _languageService;

  static const accountUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const tokenUrl = 'https://securetoken.googleapis.com/v1/token';

  late String dbUrl;

  AuthRemote(
      this._httpClient, this._flavorUtil, this._timeUtil, this._languageService)
      : dbUrl = '${_flavorUtil.currentConfig.values.firebaseDBUrl}users';

  Future<AuthResponsePayload> signIn(String email, String password) async {
    AuthResponsePayload authResponse = await _signInUser(email, password);

    _updateUser(authResponse.localId);

    return authResponse;
  }

  Future<void> signUp(String email, String password) async {
    AuthResponsePayload authResponse = await _signUpUser(email, password);

    _saveUser(authResponse, email);

    _sendVerificationEmail(authResponse.idToken);
  }

  Future<RefreshTokenResponsePayload> refreshToken(String refreshToken) async {
    final refreshTokenPayload = RefreshTokenRequestPayload(refreshToken);
    final response = await _httpClient.post(
        url: tokenUrl, data: json.encode(refreshTokenPayload.toJson()));

    return RefreshTokenResponsePayload.fromJson(response.data);
  }

  Future<AuthResponsePayload> _signInUser(String email, String password) async {
    final authRequestPayload = AuthRequestPayload(email, password);
    final response = await _httpClient.post(
        url: '${accountUrl}signInWithPassword',
        data: json.encode(authRequestPayload.toJson()));

    final authResponse = AuthResponsePayload.fromJson(response.data);
    return authResponse;
  }

  Future<AuthResponsePayload> _signUpUser(String email, String password) async {
    final authRequestPayload = AuthRequestPayload(email, password);
    final response = await _httpClient.post(
        url: '${accountUrl}signUp',
        data: json.encode(authRequestPayload.toJson()));

    final authResponse = AuthResponsePayload.fromJson(response.data);

    return authResponse;
  }

  Future<void> _saveUser(
      AuthResponsePayload authResponsePayload, String email) async {
    final user = RemoteUser(
        authId: authResponsePayload.localId,
        email: email,
        registrationDate: _timeUtil.now(),
        consented: true,
        consentUrl: 'privacy-policy');

    final data = json.encode(user.toJson());

    await _httpClient.post(url: '$dbUrl.json', data: data);
  }

  Future<void> _updateUser(String authId) async {
    final queryUrl = '$dbUrl.json?orderBy="authId"&equalTo="$authId"';
    final response = await _httpClient.get(url: queryUrl);

    final userId = response.data.keys.first;

    final updateUrl = '$dbUrl/$userId.json';

    await _httpClient.patch(
        url: updateUrl,
        data: json.encode(UpdateUserRequestPayload(_timeUtil.now())));
  }

  Future<void> _sendVerificationEmail(String token) async {
    final sendVerificationEmailPayload = SendVerificationEmailPayload(idToken: token);

    const url = '${accountUrl}sendObbCode';

    await _httpClient.post(url: url, data: jsonEncode(sendVerificationEmailPayload.toJson()), headers: {'X-Firebase-Locale': _languageService.locale});
  }
}
