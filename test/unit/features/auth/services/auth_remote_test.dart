import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_remote.dart';
import 'package:konfiso/features/auth/model/auth_request_payload.dart';
import 'package:konfiso/features/auth/services/auth_response_payload.dart';
import 'package:konfiso/features/auth/model/refresh_token_request_payload.dart';
import 'package:konfiso/features/auth/model/refresh_token_response_payload.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/secret.dart';
import 'package:konfiso/shared/services/flavor_service.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  group('AuthRemote', () {
    late AuthRemote authRemote;
    late HttpClient httpClient;
    late AuthRequestPayload authRequestPayload;
    late AuthResponsePayload authResponsePayload;
    late String email;
    late String password;
    late String signInUrl;
    late String signUpUrl;
    late String refreshToken;
    late RefreshTokenRequestPayload refreshTokenRequestPayload;
    late RefreshTokenResponsePayload refreshTokenResponsePayload;
    late String refreshTokenUrl;
    late String apiKey;

    setUp(() {
      httpClient = MockHttpClient();
      authRemote = AuthRemote(httpClient);
      email = 'test@test.com';
      password = '123456';
      authRequestPayload = AuthRequestPayload(email, password);
      authResponsePayload = const AuthResponsePayload('', '', '', '3600');
      signInUrl =
          '${AuthRemote.accountUrl}signInWithPassword';
      signUpUrl = '${AuthRemote.accountUrl}signUp';
      refreshToken = 'token';
      refreshTokenRequestPayload = RefreshTokenRequestPayload(refreshToken);
      refreshTokenResponsePayload =
          RefreshTokenResponsePayload(refreshToken, '', '', '3600');
      refreshTokenUrl = AuthRemote.tokenUrl;
    });

    void arrangeAuthReturnsWithAuthResponsePayload(String authUrl) {
      when(() => httpClient.post(
              url: authUrl, data: jsonEncode(authRequestPayload.toJson())))
          .thenAnswer((_) => Future.value(Response(
              requestOptions: RequestOptions(path: authUrl),
              data: authResponsePayload.toJson())));
    }

    void arrangeRefreshTokenReturnsWithRefreshTokenResponsePayload() {
      when(() => httpClient.post(
              url: refreshTokenUrl,
              data: jsonEncode(refreshTokenRequestPayload.toJson())))
          .thenAnswer((_) => Future.value(Response(
              requestOptions: RequestOptions(path: refreshTokenUrl),
              data: refreshTokenResponsePayload.toJson())));
    }

    group('signIn', () {
      test(
          'should call http client\'s post method with the appropriate parameters',
          () {
        arrangeAuthReturnsWithAuthResponsePayload(signInUrl);

        authRemote.signIn(email, password);

        verify(() => httpClient.post(
            url: signInUrl, data: jsonEncode(authRequestPayload.toJson())));
      });

      test('should return the converted data which comes from the http client',
          () async {
        arrangeAuthReturnsWithAuthResponsePayload(signInUrl);

        expectLater(
            await authRemote.signIn(email, password), authResponsePayload);
      });
    });
    group('signUp', () {
      test(
          'should call http client\'s post method with the appropriate parameters',
          () {
        arrangeAuthReturnsWithAuthResponsePayload(signUpUrl);

        authRemote.signUp(email, password);

        verify(() => httpClient.post(
            url: signUpUrl, data: jsonEncode(authRequestPayload.toJson())));
      });
    });
    group('refreshToken', () {
      test('should call http client post method with appropriate parameters', () {
        arrangeRefreshTokenReturnsWithRefreshTokenResponsePayload();

        authRemote.refreshToken(refreshToken);

        verify(() => httpClient.post(url: refreshTokenUrl, data: jsonEncode(refreshTokenRequestPayload.toJson())));
      });
      test('should return the converted data which comes from the http client', () async {
        arrangeRefreshTokenReturnsWithRefreshTokenResponsePayload();

        expectLater(await authRemote.refreshToken(refreshToken), refreshTokenResponsePayload);
      });
    });
  });
}
