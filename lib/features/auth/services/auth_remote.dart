import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/data/auth_request_payload.dart';
import 'package:konfiso/features/auth/data/auth_response_payload.dart';
import 'package:konfiso/features/auth/data/refresh_token_request_payload.dart';
import 'package:konfiso/features/auth/data/refresh_token_response_payload.dart';
import 'package:konfiso/features/auth/data/remote_user.dart';
import 'package:konfiso/features/auth/data/send_password_reset_email_request_payload.dart';
import 'package:konfiso/features/auth/data/send_verification_email_request_payload.dart';
import 'package:konfiso/features/auth/data/update_user_request_payload.dart';
import 'package:konfiso/features/auth/data/user_info_request_payload.dart';
import 'package:konfiso/features/auth/data/user_info_response_payload.dart';
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

  static const accountUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const tokenUrl = 'https://securetoken.googleapis.com/v1/token';

  late String dbUrl;

  AuthRemote(this._httpClient, this._flavorUtil, this._timeUtil, this._languageService) {
    dbUrl = '${_flavorUtil.currentConfig.values.firebaseDBUrl}users';
  }

  Future<AuthResponsePayload> signIn(String email, String password) async {
    AuthResponsePayload authResponse = await _signInUser(email, password);

    var userId = await _fetchUserIdByAuthId(authResponse.localId);

    _updateUser(userId);

    authResponse = authResponse.copyWith(userId: userId);

    return authResponse;
  }

  Future<AuthResponsePayload> signUp(String email, String password, String privacyPolicy) async {
    AuthResponsePayload authResponse = await _signUpUser(email, password);

    _saveUser(authResponse.localId, email, privacyPolicy);

    _sendVerificationEmail(authResponse.idToken);

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

  Future<AuthResponsePayload> _signInUser(String email, String password) async {
    final authRequestPayload = AuthRequestPayload(email, password);
    final response =
        await _httpClient.post(url: '${accountUrl}signInWithPassword', data: json.encode(authRequestPayload.toJson()));

    final authResponse = AuthResponsePayload.fromJson(response.data);
    return authResponse;
  }

  Future<AuthResponsePayload> _signUpUser(String email, String password) async {
    final authRequestPayload = AuthRequestPayload(email, password);
    final response = await _httpClient.post(url: '${accountUrl}signUp', data: json.encode(authRequestPayload.toJson()));

    final authResponse = AuthResponsePayload.fromJson(response.data);

    return authResponse;
  }

  Future<void> _saveUser(String authId, String email, String privacyPolicy) async {
    final user = RemoteUser(authId: authId, consented: true, consentUrl: privacyPolicy);

    final url = '$dbUrl.json';
    final data = json.encode(user.toJson());

    await _httpClient.post(url: url, data: data);
  }

  Future<void> _updateUser(String userId) async {
    final updateUrl = '$dbUrl/$userId.json';

    await _httpClient.patch(url: updateUrl, data: json.encode(UpdateUserRequestPayload(_timeUtil.now())));
  }

  Future<dynamic> _fetchUserIdByAuthId(String authId) async {
    final queryUrl = '$dbUrl.json?orderBy="authId"&equalTo="$authId"';
    final response = await _httpClient.get(url: queryUrl);

    final userId = response.data.keys.first;
    return userId;
  }

  Future<void> _sendVerificationEmail(String token) async {
    const url = '${accountUrl}sendOobCode';
    final sendVerificationEmailRequestPayload = jsonEncode(SendVerificationEmailPayload(idToken: token).toJson());

    await _httpClient.post(
        url: url, data: sendVerificationEmailRequestPayload, headers: {'X-Firebase-Locale': _languageService.locale});
  }
}
