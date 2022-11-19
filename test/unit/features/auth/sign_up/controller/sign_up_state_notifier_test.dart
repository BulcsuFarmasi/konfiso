@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_exception.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpRepository extends Mock implements SignUpRepository {}

class MockAuthService extends Mock implements AuthService {}

void main() {
  group('SignUpPageStateNotifier', () {
    late SignUpPageStateNotifier signUpPageStateNotifier;
    late SignUpRepository signUpRepository;
    late String email;
    late String password;

    void arrangeRepositoryThrowsException() {
      when(() => signUpRepository.signUp(email, password))
          .thenThrow(SignUpException(SignUpError.other));
    }

    setUp(() {
      signUpRepository = MockSignUpRepository();
      signUpPageStateNotifier = SignUpPageStateNotifier(signUpRepository);
      email = 'test@test.com';
      password = '123456';
    });

    test('should emit initial state', () {
      expect(signUpPageStateNotifier.state, const SignUpPageState.initial());
    });

    group('signUp', () {
      test('should call repository\'s signUp method', () {
        when(() => signUpRepository.signUp(email, password))
            .thenAnswer((_) => Future.value(null));
        signUpPageStateNotifier.signUp(email, password);
        verify(() => signUpRepository.signUp(email, password));
      });
      test('should emit inProgress and successful states in case of success',
          () async {
        when(() => signUpRepository.signUp(email, password))
            .thenAnswer((_) => Future.value(null));
        signUpPageStateNotifier.signUp(email, password);

        expect(
            signUpPageStateNotifier.state, const SignUpPageState.inProgress());

        await Future.delayed(const Duration(milliseconds: 500));

        expect(
            signUpPageStateNotifier.state, const SignUpPageState.successful());
      });
      test('should emit error states in case of error', () {
        arrangeRepositoryThrowsException();
        signUpPageStateNotifier.signUp(email, password);

        expect(signUpPageStateNotifier.state,
            const SignUpPageState.error(SignUpError.other));
      });
    });
  });
}
