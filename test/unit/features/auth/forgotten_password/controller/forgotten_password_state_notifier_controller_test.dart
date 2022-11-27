import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/forgotten_password/controller/forgotten_password_page_state.dart';
import 'package:konfiso/features/auth/forgotten_password/controller/forgotten_password_page_state_notifier.dart';
import 'package:konfiso/features/auth/forgotten_password/model/forgotten_password_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockForgottenPasswordRepository extends Mock implements ForgottenPasswordRepository {}

void main() {
  group('ForgottenPasswordPageStateNotifier', () {
    late ForgottenPasswordPageStateNotifier forgottenPasswordPageStateNotifier;
    late ForgottenPasswordRepository forgottenPasswordRepository;

    setUp(() {
      forgottenPasswordRepository = MockForgottenPasswordRepository();
      forgottenPasswordPageStateNotifier = ForgottenPasswordPageStateNotifier(forgottenPasswordRepository);
    });

    void arrangeRepositorySendEmailReturns() {
      when(() => forgottenPasswordRepository.sendEmail('a')).thenAnswer((_) => Future.value(null));
    }

    test('should emit initiak', () {
      // check if state is initial
      expect(forgottenPasswordPageStateNotifier.state, const ForgottenPasswordPageState.initial());
    });

    group('sendEmail', () {
      test('should call repository\'s sendEmail method', () {
       // arrange method returns
        arrangeRepositorySendEmailReturns();
       // call sendEmail
        forgottenPasswordPageStateNotifier.sendEmail('a');
       // verify call
        verify(() => forgottenPasswordRepository.sendEmail('a'));
      });
    });
  });
}
