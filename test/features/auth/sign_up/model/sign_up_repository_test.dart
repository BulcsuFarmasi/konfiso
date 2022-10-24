@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_repository.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthService>()])
import 'sign_up_repository_test.mocks.dart';

void main() {
  group('SignUpRepository', () {
    late SignUpRepository signUpRepository;
    late AuthService authService;
    late String email;
    late String password;
    setUp(() {
      authService = MockAuthService();
      signUpRepository = SignUpRepository(authService);

      email = 'test@test.com';
      password = '123456';
    });

    group('signUp', () {
      test('should call auth service\'s signUp method', () {
        signUpRepository.signUp(email, password);
        verify(authService.signUp(email, password));
      });
    });
  });
}