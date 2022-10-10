import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:konfiso/features/auth/services/auth_request_payload.dart';
import 'package:konfiso/features/auth/services/auth_response_payload.dart';
import 'package:konfiso/features/auth/services/refresh_token_request_payload.dart';
import 'package:konfiso/features/auth/services/refresh_token_response_payload.dart';
import 'package:konfiso/features/auth/services/stored_user.dart';
import 'package:konfiso/shared/expcetions/network_execption.dart';
import 'package:konfiso/shared/providers/http_client_provider.dart';
import 'package:konfiso/shared/providers/secure_storage_provider.dart';
import 'package:konfiso/shared/secret.dart';
import 'package:konfiso/shared/storage_keys.dart';

final authServiceProvider = Provider((Ref ref) =>
    AuthService(ref.read(httpClientProvider), ref.read(secureStorageProvider)));

class AuthService {
  final Dio _httpClient;
  final FlutterSecureStorage _secureStorage;
  Timer? refreshTimer;
  StoredUser? user;
  static const url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  AuthService(this._httpClient, this._secureStorage);

  Future<bool> autoSignIn() async {
    await _fetchUser();
    if (user != null) {
      _refreshToken();
      return true;
    } else {
      return false;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final authRequestPayload = AuthRequestPayload(email, password);
      final response = await _httpClient.post(
          '${url}signInWithPassword?key=$firebaseApiKey',
          data: jsonEncode(authRequestPayload.toJson()));
      final authResponse = AuthResponsePayload.fromJson(response.data);
      user = StoredUser(
          userId: authResponse.localId,
          token: authResponse.idToken,
          refreshToken: authResponse.refreshToken,
          validUntil: DateTime.now()
              .add(Duration(seconds: int.parse(authResponse.expiresIn))));
      _saveUser();
      _startTimer(int.parse(authResponse.expiresIn));
    } on DioError catch (e) {
      throw NetworkException(e.response!.data['error']['message']);
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final authRequestPayload = AuthRequestPayload(email, password);
      await _httpClient.post('${url}signUp?key=$firebaseApiKey',
          data: jsonEncode(authRequestPayload.toJson()));
    } on DioError catch (e) {
      throw NetworkException(e.response!.data['error']['message']);
    }
  }

  void signOut() {
    _cancelTimer();
    _deleteUser();
    user = null;
  }

  void _refreshToken() async {
    final refreshTokenPayload = RefreshTokenRequestPayload(user!.refreshToken);
    final response = await _httpClient.post(
        'https://securetoken.googleapis.com/v1/token?key=$firebaseApiKey',
        data: jsonEncode(refreshTokenPayload.toJson()));

    final responsePayload = RefreshTokenResponsePayload.fromJson(response.data);

    user = StoredUser(
        userId: responsePayload.user_id,
        token: responsePayload.id_token,
        refreshToken: responsePayload.refresh_token,
        validUntil: DateTime.now()
            .add(Duration(seconds: int.parse(responsePayload.expires_in))));

    _saveUser();

    _startTimer(int.parse(responsePayload.expires_in));
  }

  Future<void> _fetchUser() async {
    final storedUser = await _secureStorage.read(key: storedUserKey);
    if (storedUser != null) {
      user = StoredUser.fromJson(jsonDecode(storedUser));
    }
  }

  void _saveUser() {
    _secureStorage.write(key: storedUserKey, value: jsonEncode(user!.toJson()));
  }

  void _deleteUser() {
    _secureStorage.delete(key: storedUserKey);
  }

  void _startTimer(int seconds) {
    refreshTimer = Timer(Duration(seconds: seconds), _refreshToken);
  }

  void _cancelTimer() {
    if (refreshTimer != null && refreshTimer!.isActive) {
      refreshTimer!.cancel();
    }
  }
}
