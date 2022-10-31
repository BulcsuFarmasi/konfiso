import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/loading/controller/loading_page_state_notifier.dart';
import 'package:konfiso/features/loading/controller/loading_state.dart';
import 'package:konfiso/features/loading/model/loading_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLoadingRepository extends Mock implements LoadingRepository {}

void main() {
  group('LoadingPageStateNotifier', () {
    late LoadingPageStateNotifier loadingPageStateNotifier;
    late LoadingRepository loadingRepository;
    setUp(() {
      loadingRepository = MockLoadingRepository();
      loadingPageStateNotifier = LoadingPageStateNotifier(loadingRepository);
    });
    test('should emit the laoding state', () {
      expect(loadingPageStateNotifier.state, const LoadingPageState());
    });

    group('autoSignIn', () {
      test('should call repository\'s autoSignIn', () {
        when(() => loadingRepository.autoSignIn())
            .thenAnswer((_) => Future.value(true));
        loadingPageStateNotifier.autoSignIn();
        verify(() => loadingRepository.autoSignIn());
      });
      test('should return with true if repository returns with true', () async {
        when(() => loadingRepository.autoSignIn())
            .thenAnswer((_) => Future.value(true));
        expect(await loadingPageStateNotifier.autoSignIn(), true);
      });
      test('should return with true if repository returns with true', () async {
        when(() => loadingRepository.autoSignIn())
            .thenAnswer((_) => Future.value(false));
        loadingPageStateNotifier.autoSignIn();
        expect(await loadingPageStateNotifier.autoSignIn(), false);
      });
    });
  });
}
