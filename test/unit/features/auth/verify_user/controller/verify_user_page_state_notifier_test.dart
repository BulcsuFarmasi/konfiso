import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/verify_user/controller/verify_user_page_state_notifier.dart';
import 'package:konfiso/features/auth/verify_user/model/verify_user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockVerifyUserRepository extends Mock implements VerifyUserRepository {}

void main() {
  group('VerifyUserPageStateNotifier', () {
    late VerifyUserPageStateNotifier verifyUserPageStateNotifier;
    late VerifyUserRepository verifyUserRepository;

    setUp(() {
      verifyUserRepository = MockVerifyUserRepository();
      verifyUserPageStateNotifier = VerifyUserPageStateNotifier(verifyUserRepository);
    });

    void arrangeRepositoryCheckVerificationReturns() {
      when(() => verifyUserRepository.checkVerification()).thenAnswer((_) => Future.value(null));
    }

    group('checkVerification', () {
      test('should call repository\'s checkVerificaton method', () {
        arrangeRepositoryCheckVerificationReturns();

        verifyUserPageStateNotifier.checkVerification();

        verify(() => verifyUserRepository.checkVerification());
      });
    });
  });
}
