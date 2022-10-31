@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/loading/model/loading_repository.dart';

import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  group('LoadingRepository', () {
    late LoadingRepository loadingRepository;
    late AuthService authService;
    setUp(() {
      authService = MockAuthService();
      loadingRepository = LoadingRepository(authService);
    });
    group('autoSignIn', () {
      test('should call auth service\'s autoSignUp', () {
        when(() => loadingRepository.autoSignIn()).thenAnswer((_) => Future.value(true));
        loadingRepository.autoSignIn();
        verify(() => authService.autoSignIn());
      });
    });
  });
}
