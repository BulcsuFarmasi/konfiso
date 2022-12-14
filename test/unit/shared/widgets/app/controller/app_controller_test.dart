import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/widgets/app/controller/app_state_notifier.dart';
import 'package:konfiso/shared/widgets/app/model/app_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAppRepository extends Mock implements AppRepository {}

void main() {
  group('AppController ', () {
    late AppStateNotifier appStateNotifier;
    late AppRepository appRepository;

    setUp(() {
      appRepository = MockAppRepository();
      appStateNotifier = AppStateNotifier(appRepository);
    });

    void arrangeRepositorySetLocaleReturnsWithNull(String locale) {
      when(() => appRepository.setLocale(locale)).thenReturn(null);
    }

    group('setLocale', () {
      test('should call repository\'s setLocale method', () {
        const locale = 'en';
        // arrange repo
        arrangeRepositorySetLocaleReturnsWithNull(locale);
        // call controller method
        appStateNotifier.setLocale(locale);
        // verify repo is called
        verify(() => appRepository.setLocale(locale));
      });
    });
  });
}
