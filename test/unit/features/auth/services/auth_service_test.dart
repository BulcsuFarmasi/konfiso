@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_remote.dart';
import 'package:konfiso/features/auth/services/auth_response_payload.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/services/auth_storage.dart';
import 'package:konfiso/features/auth/services/refresh_token_response_payload.dart';
import 'package:konfiso/features/auth/services/stored_user.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemote extends Mock implements AuthRemote {}

class MockAuthStorage extends Mock implements AuthStorage {}

void main() {
  group('AuthService', () {
    late AuthRemote authRemote;
    late AuthStorage authStorage;
    late AuthService authService;
    late String email;
    late String password;
    setUp(() {
      authRemote = MockAuthRemote();
      authStorage = MockAuthStorage();
      authService = AuthService(authStorage, authRemote);
      email = 'test@test.com';
      password = '123456';
      registerFallbackValue(StoredUser(
          userId: '',
          token: '',
          refreshToken: '',
          validUntil: DateTime.now().add(const Duration(seconds: 3600))));
    });

    group('autoSignIn', () {
      test('should return with true if user is stored', () async {
        const refreshToken = '';
        when(() => authStorage.fetchUser()).thenAnswer((_) => Future.value(
            StoredUser(
                userId: '',
                token: '',
                refreshToken: refreshToken,
                validUntil: DateTime.now())));
        when(() => authRemote.refreshToken(refreshToken)).thenAnswer(
            (invocation) =>
                Future.value(RefreshTokenResponsePayload('', '', '', '3600')));
        expectLater(await authService.autoSignIn(), true);
      });
      test('should return with false if user is not stored', () async {
        when(() => authStorage.fetchUser())
            .thenAnswer((_) => Future.value(null));
        expectLater(await authService.autoSignIn(), false);
      });
    });

    group('sign in', () {
      test(
          'should call auth remote sign in method and auth remote save user method',
          () {
        int expiresIn = 3600;
        DateTime validUntil = DateTime.now().add(Duration(seconds: expiresIn));
        when(() => authRemote.signIn(email, password)).thenAnswer((_) =>
            Future.value(
                AuthResponsePayload('', '', '', expiresIn.toString())));
        when(() => authStorage.saveUser(StoredUser(
            userId: '', token: '', refreshToken: '', validUntil: validUntil)));
        authService.signIn(email, password);
        verify(() => authStorage.saveUser(any()));
      });
    });
  });
}
