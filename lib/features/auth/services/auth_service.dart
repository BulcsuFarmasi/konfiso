import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_exception.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/shared/expcetions/network_execption.dart';
import 'package:konfiso/shared/providers/http_client_provider.dart';
import 'package:konfiso/shared/secret.dart';

final authServiceProvider =
    Provider((Ref ref) => AuthService(ref.read(httpClientProvider)));

class AuthService {
  final Dio _httpClient;
  static const url = 'https://identitytoolkit.googleapis.com/v1/accounts:';

  AuthService(this._httpClient);

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
      await _httpClient.post('${url}signInWithPassword?key=$firebaseApiKey',
          data: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
    } on DioError catch (e) {
      throw NetworkException(e.response!.data["error"]["message"]);
    }
  }
}
