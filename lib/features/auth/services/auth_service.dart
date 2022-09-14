import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  static const url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  AuthService(this._httpClient, this._secureStorage);

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
    } on DioError catch (e) {
      throw NetworkException(e.response!.data["error"]["message"]);
    }
  }

  void _saveUserSignIn(Map<String, dynamic> userSignIn) {
    final storedUser = StoredUser(
        userId: userSignIn['localId'],
        token: userSignIn['idToken'],
        refreshToken: userSignIn['refreshToken'],
        validUntil: DateTime.now()
            .add(Duration(seconds: int.parse(userSignIn['expiresIn']))));
    _secureStorage.write(key: storedUserKey, value: value)
  }
}

class StoredUser {
  final String userId;
  final String token;
  final String refreshToken;
  final DateTime validUntil;

  StoredUser({
    required this.userId,
    required this.token,
    required this.refreshToken,
    required this.validUntil,
  });
}
