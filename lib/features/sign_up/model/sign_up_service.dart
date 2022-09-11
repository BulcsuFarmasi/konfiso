import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/providers/http_client_provider.dart';

final signUpServiceProvider = Provider((Ref ref) => SignUpService(ref.read(httpClientProvider)));

class SignUpService {
  final Dio _httpClient;

  SignUpService(this._httpClient);

  void signUp(String email, String password) {
    _httpClient.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAx0hpYb3A6hZzuWc2f7ML2cW3AlPmibRQ',
        data: {
          'email': email,
          'password': password,
          'returnSecureToken': true
        });
  }
}
