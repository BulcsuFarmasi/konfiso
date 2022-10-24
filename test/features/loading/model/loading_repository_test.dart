@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/loading/model/loading_repository.dart';

import 'package:mockito/annotations.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthService>()])
import 'loading_repository_test.mocks.dart';

void main() {
  group('LoadingRepository', () {
    late LoadingRepository loadingRepository;
    late AuthService authService;
    setUp(() {
      authService = MockAuthService();
      loadingRepository = LoadingRepository(authService);
    });
    group('autoSignIN', () {
      test('should call auth service\'s autoSignUp', () {
       loadingRepository.autoSignIn();
       verify(authService.autoSignIn());
      });
    });
  });
}