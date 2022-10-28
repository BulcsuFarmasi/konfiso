@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/shared/widgets/app.dart';
import 'package:konfiso/shared/widgets/app_drawer/model/app_drawer_repository.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthService>()])
import 'app_drawer_repository_test.mocks.dart';

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
        appDrawerRepository.signOut();
        verify(authService.signOut());
      });
    });
  });
}
