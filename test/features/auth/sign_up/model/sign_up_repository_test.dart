@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_exception.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_repository.dart';
import 'package:konfiso/shared/expcetions/network_execption.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthService>()])
import 'sign_up_repository_test.mocks.dart';

void main() {
  group('SignUpRepository', () {
    late SignUpRepository signUpRepository;
    late AuthService authService;
    late String email;
    late String password;
    setUp(() {
      authService = MockAuthService();
      signUpRepository = SignUpRepository(authService);

      email = 'test@test.com';
      password = '123456';
    });

    group('signUp', () {
      test('should call auth service\'s signUp method', () {
        signUpRepository.signUp(email, password);
        verify(authService.signUp(email, password));
      });

      test('should throw email exists exception if email exists', () {
        when(authService.signUp(email, password))
            .thenThrow(NetworkException('EMAIL_EXISTS'));

        expect(
            signUpRepository.signUp(email, password),
            throwsA(predicate((e) =>
            e is SignUpException && e.error == SignUpError.emailExists)));
      });
      test('should throw email operation not allowed if operation is not allowed', () {
        when(authService.signUp(email, password))
            .thenThrow(NetworkException('OPERATION_NOT_ALLOWED'));

        expect(
            signUpRepository.signUp(email, password),
            throwsA(predicate((e) =>
            e is SignUpException && e.error == SignUpError.operationNotAllowed)));
      });
      test('should throw too many attempts if too many attempts were made', () {
        when(authService.signUp(email, password))
            .thenThrow(NetworkException('TOO_MANY_ATTEMPTS_TRY_LATER'));

        expect(
            signUpRepository.signUp(email, password),
            throwsA(predicate((e) =>
            e is SignUpException && e.error == SignUpError.tooManyAttempts)));
      });
    });
  });
}