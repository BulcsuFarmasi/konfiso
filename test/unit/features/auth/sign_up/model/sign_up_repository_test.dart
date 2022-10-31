@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_exception.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_repository.dart';
import 'package:konfiso/shared/expcetions/network_execption.dart';

import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  group('SignUpRepository', () {
    late SignUpRepository signUpRepository;
    late AuthService authService;
    late String email;
    late String password;

    void arrangeServiceThrowsException(String message) {
      when(() => authService.signUp(email, password))
          .thenThrow(NetworkException(message));
    }

    setUp(() {
      authService = MockAuthService();
      signUpRepository = SignUpRepository(authService);
      email = 'test@test.com';
      password = '123456';
    });

    group('signUp', () {
      test('should call auth service\'s signUp method', () {
        when(() => authService.signUp(email, password)).thenAnswer((_) => Future.value(null));
        signUpRepository.signUp(email, password);
        verify(() => authService.signUp(email, password));
      });

      test('should throw email exists exception if email exists', () {
        arrangeServiceThrowsException('EMAIL_EXISTS');

        expect(
            signUpRepository.signUp(email, password),
            throwsA(predicate((e) =>
                e is SignUpException && e.error == SignUpError.emailExists)));
      });
      test(
          'should throw email operation not allowed if operation is not allowed',
          () {
        arrangeServiceThrowsException('OPERATION_NOT_ALLOWED');
        expect(
            signUpRepository.signUp(email, password),
            throwsA(predicate((e) =>
                e is SignUpException &&
                e.error == SignUpError.operationNotAllowed)));
      });
      test('should throw too many attempts if too many attempts were made', () {
        arrangeServiceThrowsException('TOO_MANY_ATTEMPTS_TRY_LATER');

        expect(
            signUpRepository.signUp(email, password),
            throwsA(predicate((e) =>
                e is SignUpException &&
                e.error == SignUpError.tooManyAttempts)));
      });
      test('should throw other if error is unknown', () {
        arrangeServiceThrowsException('b');

        expect(
            signUpRepository.signUp(email, password),
            throwsA(predicate(
                (e) => e is SignUpException && e.error == SignUpError.other)));
      });
    });
  });
}
