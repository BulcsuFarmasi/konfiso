import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/model/auth_request_payload.dart';
import 'package:konfiso/features/auth/model/auth_response_payload.dart';
import 'package:konfiso/features/auth/model/refresh_token_request_payload.dart';
import 'package:konfiso/features/auth/model/refresh_token_response_payload.dart';
import 'package:konfiso/features/auth/model/remote_user.dart';
import 'package:konfiso/features/auth/model/update_user_request_payload.dart';
import 'package:konfiso/features/auth/services/auth_remote.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/services/flavor_service.dart';
import 'package:konfiso/shared/services/time_service.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockTimeService extends Mock implements TimeService {}

void main() {
  group('AuthRemote', () {
    late AuthRemote authRemote;
    late HttpClient httpClient;
    late FlavorService flavorService;
    late TimeService timeService;
    late AuthRequestPayload authRequestPayload;
    late String authId;
    late String userId;
    late AuthResponsePayload authResponsePayload;
    late String email;
    late String password;
    late String signInUrl;
    late String signUpUrl;
    late String refreshToken;
    late RefreshTokenRequestPayload refreshTokenRequestPayload;
    late RefreshTokenResponsePayload refreshTokenResponsePayload;
    late String refreshTokenUrl;
    late String saveUserUrl;
    late String queryUserUrl;
    RemoteUser? remoteUser;
    late DateTime now;

    setUp(() {
      httpClient = MockHttpClient();
      flavorService = FlavorService();
      timeService = MockTimeService();
      authRemote = AuthRemote(httpClient, flavorService, timeService);
      email = 'test@test.com';
      password = '123456';
      authRequestPayload = AuthRequestPayload(email, password);
      authId = 'authId';
      userId = 'userId';
      authResponsePayload = AuthResponsePayload(authId, 'a', 'a', '3600');
      signInUrl = '${AuthRemote.accountUrl}signInWithPassword';
      signUpUrl = '${AuthRemote.accountUrl}signUp';
      refreshToken = 'token';
      refreshTokenRequestPayload = RefreshTokenRequestPayload(refreshToken);
      refreshTokenResponsePayload =
          RefreshTokenResponsePayload(refreshToken, 'a', 'a', '3600');
      refreshTokenUrl = AuthRemote.tokenUrl;
      saveUserUrl = '${authRemote.dbUrl}.json';
      queryUserUrl = '${authRemote.dbUrl}.json?orderBy="authId"&equalTo=';
      now = DateTime.now();
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

    void arrangeSaveUserReturnsWithUserId() {
      print(saveUserUrl);
      print('test: ${json.encode(remoteUser!.toJson())}');
      print(json.encode(remoteUser!.toJson()).hashCode);
      when(() => httpClient.post(
              url: saveUserUrl, data: jsonEncode(remoteUser!.toJson())))
          .thenAnswer((_) => Future.value(Response(
              requestOptions: RequestOptions(path: saveUserUrl),
              data: {'name': 'ab'})));
    }

    void arrangeQueryUserReturnsWithUsers(String authId) {
      remoteUser = RemoteUser(
          authId: authId,
          email: email,
          registrationDate: now,
          consented: true,
          consentUrl: 'privacy-policy');
      final url = '$queryUserUrl"$authId"';
      when(() => httpClient.get(url: url)).thenAnswer((_) => Future.value(
              Response(requestOptions: RequestOptions(path: url), data: {
            userId: remoteUser!.toJson(),
          })));
    }

    void arrangeUpdateUserReturnsWithUpdatedFiled(String userId) {
      final url = '${authRemote.dbUrl}/$userId.json';
      print(url);
      when(() => httpClient.patch(
              url: url,
              data: jsonEncode(UpdateUserRequestPayload(now).toJson())))
          .thenAnswer((_) => Future.value(
                  Response(requestOptions: RequestOptions(path: url), data: {
                'latestLogin': now.toIso8601String(),
              })));
    }

    void arrangeTimeServiceReturnsWithNow() {
      when(() => timeService.now()).thenReturn(now);
    }

    group('signIn', () {
      test(
          'should call http client\'s post method with the appropriate parameters',
          () {
        arrangeTimeServiceReturnsWithNow();
        arrangeAuthReturnsWithAuthResponsePayload(signInUrl);
        arrangeQueryUserReturnsWithUsers(authId);
        arrangeUpdateUserReturnsWithUpdatedFiled(userId);

        authRemote.signIn(email, password);

        verify(() => httpClient.post(
            url: signInUrl, data: jsonEncode(authRequestPayload.toJson())));
      });

      test('should return the converted data which comes from the http client',
          () async {
        arrangeTimeServiceReturnsWithNow();
        arrangeAuthReturnsWithAuthResponsePayload(signInUrl);
        arrangeQueryUserReturnsWithUsers(authId);
        arrangeUpdateUserReturnsWithUpdatedFiled(userId);

        expectLater(
            await authRemote.signIn(email, password), authResponsePayload);
      });
    });
    group('signUp', () {
      test(
          'should call http client\'s post method with the appropriate parameters',
          () {
        arrangeAuthReturnsWithAuthResponsePayload(signUpUrl);
        arrangeSaveUserReturnsWithUserId();
        arrangeTimeServiceReturnsWithNow();

        authRemote.signUp(email, password);

        verify(() => httpClient.post(
            url: signUpUrl, data: jsonEncode(authRequestPayload.toJson())));
      });
    });
    group('refreshToken', () {
      test('should call http client post method with appropriate parameters',
          () {
        arrangeRefreshTokenReturnsWithRefreshTokenResponsePayload();

        authRemote.refreshToken(refreshToken);

        verify(() => httpClient.post(
            url: refreshTokenUrl,
            data: jsonEncode(refreshTokenRequestPayload.toJson())));
      });
      test('should return the converted data which comes from the http client',
          () async {
        arrangeRefreshTokenReturnsWithRefreshTokenResponsePayload();

        expectLater(await authRemote.refreshToken(refreshToken),
            refreshTokenResponsePayload);
      });
    });
  });
}
