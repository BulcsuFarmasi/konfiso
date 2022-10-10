@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<AuthService>()])
import 'sign_in_repository.mocks.dart';

void main () {
  group('SignInRepository', () {
    group('signIn', () {
      test('should call authService signIn', () {
      print('a');
      });
    });
  });
}