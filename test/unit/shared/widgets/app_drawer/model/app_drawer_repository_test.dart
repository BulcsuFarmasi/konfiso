@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/shared/widgets/app_drawer/model/app_drawer_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  group('AppDrawerRepository', () {
    late AppDrawerRepository appDrawerRepository;
    late AuthService authService;

    setUp(() {
      authService = MockAuthService();
      appDrawerRepository = AppDrawerRepository(authService);
    });

    group('signOut', () {
      test('should service\'s signOut method', () {
        when(() => authService.signOut()).thenAnswer((_) => Future.value(null));
        appDrawerRepository.signOut();
        verify(() => authService.signOut());
      });
    });
  });
}
