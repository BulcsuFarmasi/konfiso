@TestOn('vm')
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/data/auth_response_payload.dart';
import 'package:konfiso/features/auth/data/refresh_token_response_payload.dart';
import 'package:konfiso/features/auth/data/stored_user.dart';
import 'package:konfiso/features/auth/data/user_info.dart';
import 'package:konfiso/features/auth/data/user_info_response_payload.dart';
import 'package:konfiso/features/auth/data/user_signin_status.dart';
import 'package:konfiso/features/auth/services/auth_remote.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/services/auth_storage.dart';
import 'package:konfiso/shared/utils/time_util.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemote extends Mock implements AuthRemote {}

class MockAuthStorage extends Mock implements AuthStorage {}

class MockTimeUtil extends Mock implements TimeUtil {}

void main() {
  group('AuthService', () {
    late AuthRemote authRemote;
    late AuthStorage authStorage;
    late TimeUtil timeUtil;
    late AuthService authService;
    late String email;
    late String password;
    late DateTime now;
    setUp(() {
      authRemote = MockAuthRemote();
      authStorage = MockAuthStorage();
      timeUtil = MockTimeUtil();
      authService = AuthService(authStorage, authRemote, timeUtil);
      email = 'test@test.com';
      password = '123456';
      now = DateTime.now();
      when(() => timeUtil.now()).thenReturn(now);
    });

    void arrangeAuthRemoteReturnsWithUserInfoEmailVerifiedTrue(String token) {
      when(() => authRemote.loadUserInfo(token)).thenAnswer(
        (invocation) => Future.value(const UserInfoResponsePayload(users: [UserInfo(emailVerified: true)])),
      );
    }

    void arrangeAuthRemoteReturnsWithUserInfoEmailVerfiedFalse(String token) {
      when(() => authRemote.loadUserInfo(token)).thenAnswer(
        (invocation) => Future.value(const UserInfoResponsePayload(users: [UserInfo(emailVerified: false)])),
      );
    }

    group('autoSignIn', () {
      test('should return with signed in status if user is stored and is verified', () async {
        const refreshToken = '';
        when(() => authStorage.fetchUser()).thenAnswer(
          (_) => Future.value(
            StoredUser(
              authId: '',
              userId: '',
              token: '',
              refreshToken: refreshToken,
              validUntil: now,
              verified: true,
            ),
          ),
        );
        when(() => authRemote.refreshToken(refreshToken))
            .thenAnswer((invocation) => Future.value(const RefreshTokenResponsePayload('', '', '', '3600')));
        expectLater(await authService.autoSignIn(), UserSignInStatus.signedIn);
      });
      test('should return with not verified status if user is stored but is not verified', () async {
        const refreshToken = '';
        when(() => authStorage.fetchUser()).thenAnswer(
          (_) => Future.value(
            StoredUser(
              userId: '',
              authId: '',
              token: '',
              refreshToken: refreshToken,
              validUntil: now,
              verified: false,
            ),
          ),
        );
        expectLater(await authService.autoSignIn(), UserSignInStatus.notVerified);
      });
      test('should return with false if user is not stored', () async {
        when(() => authStorage.fetchUser()).thenAnswer((_) => Future.value(null));
        expectLater(await authService.autoSignIn(), UserSignInStatus.notSignedIn);
      });
    });

    group('sign in', () {
      test('should call auth remote sign in method', () {
        const expiresIn = 3600;

        when(() => authRemote.signIn(email, password))
            .thenAnswer((_) => Future.value(AuthResponsePayload('', '', '', expiresIn.toString())));

        authService.signIn(email, password);

        verify(() => authRemote.signIn(email, password));

        // TODO verify authStorage saveUser
      });
      test('should throw network exception if network call is failed', () {
        final requestOptions = RequestOptions(
          path: '${AuthRemote.accountUrl}signInWithPassword',
        );
        final response = Response(requestOptions: requestOptions, data: {
          'error': {'message': 'INVALID_EMAIL'}
        });

        when(() => authRemote.signIn(email, password))
            .thenThrow(DioError(requestOptions: requestOptions, response: response));

        expect(authService.signIn(email, password), throwsException);
      });
    });
    group('sign up', () {
      test('should call auth remote sign up method', () {
        when(() => authRemote.signUp(email, password)).thenAnswer((_) => Future.value(null));

        authService.signUp(email, password);

        verify(() => authRemote.signUp(email, password));
      });
      test('should throw network exception if network call is failed', () {
        final requestOptions = RequestOptions(
          path: '${AuthRemote.accountUrl}signUp',
        );
        final response = Response(requestOptions: requestOptions, data: {
          'error': {'message': 'EMAIL_EXISTS'}
        });

        when(() => authRemote.signUp(email, password))
            .thenThrow(DioError(requestOptions: requestOptions, response: response));

        expect(authService.signUp(email, password), throwsException);
      });
    });
    group('signOut', () {
      test('should call auth remote delete user', () {
        when(() => authStorage.deleteUser()).thenAnswer((_) => Future.value(null));
        authService.signOut();
        verify(() => authStorage.deleteUser());
      });
      test('should set user to null', () {
        authService.user = StoredUser(
          authId: '',
          userId: '',
          token: '',
          refreshToken: '',
          validUntil: now,
          verified: true,
        );
        authService.signOut();

        expect(authService.user, isNull);
      });
    });
    group('checkVerification', () {
      test('should call auth remote loadUserInfo after 2 seconds', () async {
        authService.user = StoredUser(
          authId: 'auth_id',
          userId: 'user_id',
          token: 'id_token',
          refreshToken: 'a',
          validUntil: now,
          verified: true,
        );
        arrangeAuthRemoteReturnsWithUserInfoEmailVerifiedTrue('id_token');

        authService.checkVerification();

        await Future.delayed(const Duration(seconds: 2));

        verify(() => authRemote.loadUserInfo('id_token'));
      });
      test('should complete the future if email verified is true', () async {
        authService.user = StoredUser(
            authId: 'authId', userId: 'user_id', token: 'id_token', refreshToken: 'a', validUntil: now, verified: true);
        arrangeAuthRemoteReturnsWithUserInfoEmailVerifiedTrue('id_token');

        final future = authService.checkVerification();

        await Future.delayed(const Duration(seconds: 2));

        expect(future, completes);
      });
      test('should not complete the future if email verified is false', () async {
        authService.user = StoredUser(
            authId: 'auth_id',
            userId: 'user_id',
            token: 'id_token',
            refreshToken: 'a',
            validUntil: now,
            verified: true);
        arrangeAuthRemoteReturnsWithUserInfoEmailVerfiedFalse('id_token');

        final future = authService.checkVerification();

        await Future.delayed(const Duration(seconds: 2));

        expect(future, doesNotComplete);
      });
    });
  });
}
