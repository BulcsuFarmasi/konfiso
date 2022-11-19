import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/data/auth_request_payload.dart';
import 'package:konfiso/features/auth/data/auth_response_payload.dart';
import 'package:konfiso/features/auth/data/refresh_token_request_payload.dart';
import 'package:konfiso/features/auth/data/refresh_token_response_payload.dart';
import 'package:konfiso/features/auth/data/remote_user.dart';
import 'package:konfiso/features/auth/data/update_user_request_payload.dart';
import 'package:konfiso/features/auth/services/auth_remote.dart';
import 'package:konfiso/shared/http_client.dart';
import 'package:konfiso/shared/utils/flavor_util.dart';
import 'package:konfiso/shared/utils/time_util.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockTimeUtil extends Mock implements TimeUtil {}

void main() {
  group('AuthRemote', () {
    late AuthRemote authRemote;
    late HttpClient httpClient;
    late FlavorUtil flavorUtil;
    late TimeUtil timeUtil;
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
      flavorUtil = FlavorUtil();
      timeUtil = MockTimeUtil();
      authRemote = AuthRemote(httpClient, flavorUtil, timeUtil);
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
      when(() => httpClient.patch(
              url: url,
              data: jsonEncode(UpdateUserRequestPayload(now).toJson())))
          .thenAnswer((_) => Future.value(
                  Response(requestOptions: RequestOptions(path: url), data: {
                'latestLogin': now.toIso8601String(),
              })));
    }

    void arrangeTimeUtilReturnsWithNow() {
      when(() => timeUtil.now()).thenReturn(now);
    }

    group('signIn', () {
      test(
          'should call http client\'s post method with the appropriate parameters',
          () {
        arrangeTimeUtilReturnsWithNow();
        arrangeAuthReturnsWithAuthResponsePayload(signInUrl);
        arrangeQueryUserReturnsWithUsers(authId);
        arrangeUpdateUserReturnsWithUpdatedFiled(userId);

        authRemote.signIn(email, password);

        verify(() => httpClient.post(
            url: signInUrl, data: jsonEncode(authRequestPayload.toJson())));
      });

      test('should return the converted data which comes from the http client',
          () async {
        arrangeTimeUtilReturnsWithNow();
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
        arrangeTimeUtilReturnsWithNow();

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
