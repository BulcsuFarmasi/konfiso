import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  StoredUser? user;
  static const url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  AuthService(this._httpClient, this._secureStorage);

  void refreshToken() async {
    final response = await _httpClient.post(
        'https://securetoken.googleapis.com/v1/token?key=$firebaseApiKey',
        data: jsonEncode({
          'grant_type': 'refresh_token',
          'refresh_token': user!.refreshToken
        }));
  }

  Future<void> signIn(String email, String password) async {
    try {
      final response =
          await _httpClient.post('${url}signInWithPassword?key=$firebaseApiKey',
              data: jsonEncode({
                'email': email,
                'password': password,
                'returnSecureToken': true,
              }));
      _saveUserSignIn(response.data);
      Timer(const Duration(minutes: 1), refreshToken);
    } on DioError catch (e) {
      throw NetworkException(e.response!.data["error"]["message"]);
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _httpClient.post('${url}signUp?key=$firebaseApiKey',
          data: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
    } on DioError catch (e) {
      throw NetworkException(e.response!.data["error"]["message"]);
    }
  }

  void _saveUserSignIn(Map<String, dynamic> userSignIn) {
    user = StoredUser(
        userId: userSignIn['localId'],
        token: userSignIn['idToken'],
        refreshToken: userSignIn['refreshToken'],
        validUntil: DateTime.now()
            .add(Duration(seconds: int.parse(userSignIn['expiresIn']))));
    _secureStorage.write(
        key: storedUserKey, value: jsonEncode(user!.toJson()));
  }
}
