import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/data/user_signin_status.dart';
import 'package:konfiso/features/loading/controller/loading_page_controller.dart';
import 'package:konfiso/features/loading/model/loading_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLoadingRepository extends Mock implements LoadingRepository {}

void main() {
  group('LoadingPageStateNotifier', () {
    late LoadingPageController loadingPageController;
    late LoadingRepository loadingRepository;
    setUp(() {
      loadingRepository = MockLoadingRepository();
      loadingPageController = LoadingPageController(loadingRepository);
    });

    group('autoSignIn', () {
      test('should call repository\'s autoSignIn', () {
        when(() => loadingRepository.autoSignIn())
            .thenAnswer((_) => Future.value(UserSignInStatus.signedIn));
        loadingPageController.autoSignIn();
        verify(() => loadingRepository.autoSignIn());
      });
      test('should return with signed if repository returns with signed in', () async {
        when(() => loadingRepository.autoSignIn())
            .thenAnswer((_) => Future.value(UserSignInStatus.signedIn));
        expect(await loadingPageController.autoSignIn(), UserSignInStatus.signedIn);
      });
      test('should return with not signed in if repository returns with not signed in', () async {
        when(() => loadingRepository.autoSignIn())
            .thenAnswer((_) => Future.value(UserSignInStatus.notSignedIn));
        loadingPageController.autoSignIn();
        expect(await loadingPageController.autoSignIn(), UserSignInStatus.notSignedIn);
      });
      test('should return with not verified in if repository returns with not verified', () async {
        when(() => loadingRepository.autoSignIn())
            .thenAnswer((_) => Future.value(UserSignInStatus.notSignedIn));
        loadingPageController.autoSignIn();
        expect(await loadingPageController.autoSignIn(), UserSignInStatus.notSignedIn);
      });
    });
  });
}
