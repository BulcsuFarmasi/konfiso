import 'package:flutter_test/flutter_test.dart';
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
            .thenAnswer((_) => Future.value(true));
        loadingPageController.autoSignIn();
        verify(() => loadingRepository.autoSignIn());
      });
      test('should return with true if repository returns with true', () async {
        when(() => loadingRepository.autoSignIn())
            .thenAnswer((_) => Future.value(true));
        expect(await loadingPageController.autoSignIn(), true);
      });
      test('should return with true if repository returns with true', () async {
        when(() => loadingRepository.autoSignIn())
            .thenAnswer((_) => Future.value(false));
        loadingPageController.autoSignIn();
        expect(await loadingPageController.autoSignIn(), false);
      });
    });
  });
}
