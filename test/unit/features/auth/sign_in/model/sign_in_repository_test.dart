@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_repository.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_up_expection.dart';
import 'package:konfiso/shared/expcetions/network_execption.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthService>()])
import 'sign_in_repository_test.mocks.dart';

void main() {
  group('SignInRepository', () {
    group('signIn', () {
      late AuthService authService;
      late SignInRepository signInRepository;
      late String email;
      late String password;

      void arrangeServiceThrowsException(String message) {
        when(authService.signIn(email, password))
            .thenThrow(NetworkException(message));
      }

      setUp(() {
        authService = MockAuthService();
        signInRepository = SignInRepository(authService);
        email = 'test@test.com';
        password = '123456';
      });
      test('should call authService signIn', () {
        signInRepository.signIn(email, password);

        verify(authService.signIn(email, password));
      });
      test('should throw invalid email exception if email is invalid', () {
        arrangeServiceThrowsException('INVALID_EMAIL');

        expect(
            signInRepository.signIn(email, password),
            throwsA(predicate((e) =>
                e is SignInException && e.error == SignInError.invalidEmail)));
      });
      test('should throw invalid password exception if password is invalid',
          () {
        arrangeServiceThrowsException('INVALID_PASSWORD');

        expect(
            signInRepository.signIn(email, password),
            throwsA(predicate((e) =>
                e is SignInException &&
                e.error == SignInError.invalidPassword)));
      });
      test('should throw iuser disabled exception if user is disabled', () {
        arrangeServiceThrowsException('USER_DISABLED');

        expect(
            signInRepository.signIn(email, password),
            throwsA(predicate((e) =>
                e is SignInException && e.error == SignInError.userDisabled)));
      });
      test('should throw other exception if the error is unkown', () {
        arrangeServiceThrowsException('a');

        expect(
            signInRepository.signIn(email, password),
            throwsA(predicate(
                (e) => e is SignInException && e.error == SignInError.other)));
      });
    });
  });
}
