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
  Timer? refreshTimer;
  StoredUser? user;
  static const url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  AuthService(this._httpClient, this._secureStorage);

  void refreshToken() async {
    print('token');
    final response = await _httpClient.post(
        'https://securetoken.googleapis.com/v1/token?key=$firebaseApiKey',
        data: jsonEncode({
          'grant_type': 'refresh_token',
          'refresh_token': user!.refreshToken
        }));

    final responseData = response.data;

    user = StoredUser(
        userId: responseData['user_id'],
        token: responseData['id_token'],
        refreshToken: responseData['refresh_token'],
        validUntil: DateTime.now()
            .add(Duration(seconds: int.parse(responseData['expires_in']))));

    _saveUser();

    _startTimer(int.parse(responseData['expires_in']));
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
      user = StoredUser(
          userId: response.data['localId'],
          token: response.data['idToken'],
          refreshToken: response.data['refreshToken'],
          validUntil: DateTime.now()
              .add(Duration(seconds: int.parse(response.data['expiresIn']))));
      _saveUser();
      _startTimer(int.parse(response.data['expiresIn']));
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

  }

  void _saveUser() {
    _secureStorage.write(key: storedUserKey, value: jsonEncode(user!.toJson()));
  }

  void _startTimer(int seconds) {
    refreshTimer = Timer(Duration(seconds: seconds), refreshToken);
  }
}
