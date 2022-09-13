import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_exception.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/shared/providers/http_client_provider.dart';
import 'package:konfiso/shared/secret.dart';

final authServiceProvider =
    Provider((Ref ref) => AuthService(ref.read(httpClientProvider)));

class AuthService {
  final Dio _httpClient;

  AuthService(this._httpClient);

  Future<void> signUp(String email, String password) async {
    try {
      await _httpClient.post(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$firebaseApiKey',
          data: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
    } on DioError catch (e) {
      final error =
          _convertMessageIntoError(e.response!.data["error"]["message"]);
      throw SignUpException(error);
    }
  }

  SignUpError _convertMessageIntoError(String message) {
    if (message == 'EMAIL_EXISTS') {
      return SignUpError.emailExits;
    } else if (message == 'OPERATION_NOT_ALLOWED') {
      return SignUpError.operationNotAllowed;
    } else if (message == 'TOO_MANY_ATTEMPTS_TRY_LATER') {
      return SignUpError.tooManyAttempts;
    } else {
      return SignUpError.other;
    }
  }
}
