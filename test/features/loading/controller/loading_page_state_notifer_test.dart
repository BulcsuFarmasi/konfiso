import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/loading/controller/loading_page_state_notifier.dart';
import 'package:konfiso/features/loading/controller/loading_state.dart';

import 'package:mockito/annotations.dart';
import 'package:konfiso/features/loading/model/loading_repository.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<LoadingRepository>()])
import 'loading_page_state_notifer_test.mocks.dart';

void main() {
  group('LoadingPageStateNotifier', () {
    late LoadingPageStateNotifier loadingPageStateNotifier;
    late LoadingRepository loadingRepository;
    setUp(() {
      loadingRepository = MockLoadingRepository();
      loadingPageStateNotifier = LoadingPageStateNotifier(loadingRepository);
    });

    group('autoSignIn', () {
      test('should emit the laoding state', () {
        expect(loadingPageStateNotifier.state, const LoadingPageState());
      });

      test('should call repository\'s autoSignIn', () {
        loadingPageStateNotifier.autoSignIn();
        verify(loadingRepository.autoSignIn());
      });
    });
  });
}