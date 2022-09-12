import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/providers/http_client_provider.dart';
import 'package:konfiso/shared/secret.dart';

final signUpServiceProvider = Provider((Ref ref) => SignUpService(ref.read(httpClientProvider)));

class SignUpService {
  final Dio _httpClient;

  SignUpService(this._httpClient);

  Future<void> signUp(String email, String password) async {
    try {
      final respose = await _httpClient.post(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$firebaseApiKey',
          data: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
    } on DioError catch(e) {
      print(e.response!.data.toString());
    }
  }
}
