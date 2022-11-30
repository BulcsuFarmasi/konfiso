import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/verify_user/model/verify_user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  group('VerifyUserRepository', () {
    late VerifyUserRepository verifyUserRepository;
    late AuthService authService;

    setUp(() {
      authService = MockAuthService();
      verifyUserRepository = VerifyUserRepository(authService);
    });

    void arrangeServiceCheckVerificationReturns() {
      when(() => authService.checkVerification()).thenAnswer((invocation) => Future.value(null));
    }

    group('checkVerification', () {
      test('should service\'s checkVerification method', () {
        // arrange
        arrangeServiceCheckVerificationReturns();
        // call
        verifyUserRepository.checkVerification();
        // verify
        verify(() => authService.checkVerification());
      });
    });
  });
}
