@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_exception.dart';

import 'package:mockito/annotations.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_repository.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<SignUpRepository>()])
import 'sign_up_state_notifier_test.mocks.dart';

void main() {
  group('SignUpPageStateNotifier', () {
    late SignUpPageStateNotifier signUpPageStateNotifier;
    late SignUpRepository signUpRepository;
    late String email;
    late String password;
    setUp(() {
      signUpRepository = MockSignUpRepository();
      signUpPageStateNotifier = SignUpPageStateNotifier(signUpRepository);
      email = 'test@test.com';
      password = '123456';
    });

    group('signUp', () {
      test('should emit initial state', ()  {
        expect(signUpPageStateNotifier.state, const SignUpPageState.initial());
      });
      test('should call repository\'s signUp method', () {
        signUpPageStateNotifier.signUp(email, password);
        verify(signUpRepository.signUp(email, password));
      });
      test('should emit loading and success state in case of success', () {
        signUpPageStateNotifier.signUp(email, password);
        emitsInOrder([
          const SignUpPageState.inProgress(),
          const SignUpPageState.successful(),
        ]);
      });
      test('should emit loading and error state in case of error', () {
        when(signUpRepository.signUp(email, password)).thenThrow(SignUpException(SignUpError.other));
        signUpPageStateNotifier.signUp(email, password);
        emitsInOrder([
          const SignUpPageState.inProgress(),
          const SignUpPageState.error(SignUpError.other),
        ]);
      });
    });
  });
}