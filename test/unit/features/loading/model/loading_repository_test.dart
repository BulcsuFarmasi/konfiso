@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/data/user_signin_status.dart';
import 'package:konfiso/features/auth/services/auth_service.dart';
import 'package:konfiso/features/loading/model/loading_repository.dart';
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
        when(() => loadingRepository.autoSignIn()).thenAnswer((_) => Future.value(UserSignInStatus.signedIn));
        loadingRepository.autoSignIn();
        verify(() => authService.autoSignIn());
      });
      test('should return signed in when the auth service returns with signed in', () async {
        when(() => loadingRepository.autoSignIn()).thenAnswer((_) => Future.value(UserSignInStatus.signedIn));
        loadingRepository.autoSignIn();
        expectLater(await loadingRepository.autoSignIn(), UserSignInStatus.signedIn);
      });
      test('should return not signed in when the auth service returns with not signed in', () async {
        when(() => loadingRepository.autoSignIn()).thenAnswer((_) => Future.value(UserSignInStatus.notSignedIn));
        loadingRepository.autoSignIn();
        expectLater(await loadingRepository.autoSignIn(), UserSignInStatus.notSignedIn);
      });
      test('should return not verified when the auth service returns with not verified', () async {
        when(() => loadingRepository.autoSignIn()).thenAnswer((_) => Future.value(UserSignInStatus.notVerified));
        loadingRepository.autoSignIn();
        expectLater(await loadingRepository.autoSignIn(), UserSignInStatus.notVerified);
      });
    });
  });
}
