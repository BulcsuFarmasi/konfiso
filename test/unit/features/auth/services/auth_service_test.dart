@TestOn('vm')
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/services/refresh_token_request_payload.dart';
import 'package:konfiso/features/auth/services/refresh_token_response_payload.dart';
import 'package:konfiso/features/auth/services/stored_user.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/secret.dart';
import 'package:konfiso/shared/secure_storage.dart';
import 'package:konfiso/shared/storage_keys.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  group('AuthService', () {
    late HttpClient httpClient;
    late SecureStorage secureStorage;
    late AuthService authService;
    late String email;
    late String password;
    setUp(() {
      httpClient = MockHttpClient();
      secureStorage = MockSecureStorage();
      authService = AuthService(httpClient, secureStorage);
      email = 'test@test.com';
      password = '123456';
    });

    group('autoSignIn', () {
      test('should return with true is user is defined', () async {
        final user = StoredUser(
            userId: '',
            token: '',
            refreshToken: '',
            validUntil: DateTime.now());
        when(() => secureStorage.read(storedUserKey))
            .thenAnswer((_) => Future.value(jsonEncode(user.toJson())));

        const url =
            'https://securetoken.googleapis.com/v1/token?key=$firebaseApiKey';

        print(httpClient.runtimeType);

        when(() => httpClient.post(
            url: url,
            data: jsonEncode(RefreshTokenRequestPayload(
                authService.user!.refreshToken)))).thenAnswer((invocation) {
          return Future.value(Response(
              requestOptions: RequestOptions(path: url),
              data: RefreshTokenResponsePayload('', '', '', '3600')));
        });

        await authService.autoSignIn();
      });
    });
  });
}
