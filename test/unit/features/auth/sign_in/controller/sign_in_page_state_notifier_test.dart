@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/controller/sign_in_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_in/controller/sing_in_page_state.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_repository.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_up_expection.dart';
import 'package:mocktail/mocktail.dart';

class MockSignInRepository extends Mock implements SignInRepository {}

void main() {
  group('SignInPageStateNotifier', () {
    group('signIn', () {
      late SignInPageStateNotifier signInPageStateNotifier;
      late SignInRepository signInRepository;
      late String email;
      late String password;

      void arrangeRepositoryThrowsException() {
        when(() => signInRepository.signIn(email, password)).thenThrow(SignInException(SignInError.other));
      }

      setUp(() {
        signInRepository = MockSignInRepository();
        signInPageStateNotifier = SignInPageStateNotifier(signInRepository);
        email = 'test@test.com';
        password = '123456';
      });
      test('should emit initial', () {
        expect(signInPageStateNotifier.state, const SignInPageState.initial());
      });
      test("should call repository's signIn method", () {
        when(() => signInRepository.signIn(email, password)).thenAnswer((_) => Future.value(null));
        signInPageStateNotifier.signIn(email, password);
        verify(() => signInRepository.signIn(email, password)).called(1);
      });
      test('should emit inProgress and successful states in case of success', () async {
        when(() => signInRepository.signIn(email, password)).thenAnswer((_) => Future.value(null));
        signInPageStateNotifier.signIn(email, password);

        expect(signInPageStateNotifier.state, const SignInPageState.inProgress());

        await Future.delayed(const Duration(milliseconds: 500));

        expect(signInPageStateNotifier.state, const SignInPageState.successful());
      });
      test('should emit error states in case of error', () {
        arrangeRepositoryThrowsException();
        signInPageStateNotifier.signIn(email, password);

        expect(signInPageStateNotifier.state, const SignInPageState.error(SignInError.other));
      });
    });
  });
}
