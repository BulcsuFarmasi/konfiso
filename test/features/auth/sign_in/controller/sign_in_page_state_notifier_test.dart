import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/controller/sign_in_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_in/controller/sing_in_page_state.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_repository.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_up_expection.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<SignInRepository>()])
import 'sign_in_page_state_notifier_test.mocks.dart';

void main() {
  group('SignInStateNotifier', () {
    group('signIn', () {
      late SignInPageStateNotifier signInPageStateNotifier;
      late SignInRepository signInRepository;
      late String email;
      late String password;
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
        signInPageStateNotifier.signIn(email, password);
        verify(signInRepository.signIn(email, password));
      });
      test('should emit inProgress and successful states in case of success', () {
        signInPageStateNotifier.signIn(email, password);
        emitsInOrder([
          const SignInPageState.inProgress(),
          const SignInPageState.successful()
        ]);
      });
      test('should emit inProgress and error states in case of error', () {
        when(signInRepository.signIn(email, password)).thenThrow(SignInException(SignInError.other));
        signInPageStateNotifier.signIn(email, password);
        emitsInOrder([
          const SignInPageState.inProgress(),
          const SignInPageState.error(SignInError.other)
        ]);
      });
    });
  });
}
