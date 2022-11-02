@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/widgets/app_drawer/controller/app_drawer_state_notifier.dart';
import 'package:konfiso/shared/widgets/app_drawer/model/app_drawer_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAppDrawerRepository extends Mock implements AppDrawerRepository {}

void main() {
  group('AppDrawerStateNotifier', () {
    late AppDrawerController appDrawerController;
    late AppDrawerRepository appDrawerRepository;

    setUp(() {
      appDrawerRepository = MockAppDrawerRepository();
      appDrawerController = AppDrawerController(appDrawerRepository);
    });

    group('signOut', () {
      test('should call repository\'s signOut method', () {
        when(() => appDrawerRepository.signOut()).thenAnswer((_) {
          Future.value(null);
        });
        appDrawerController.signOut();
        verify(() => appDrawerRepository.signOut());
      });
    });
  });
}
