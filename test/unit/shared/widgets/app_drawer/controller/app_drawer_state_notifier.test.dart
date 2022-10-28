@TestOn('vm')
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/widgets/app_drawer/controller/app_drawer_state.dart';
import 'package:konfiso/shared/widgets/app_drawer/controller/app_drawer_state_notifier.dart';
import 'package:konfiso/shared/widgets/app_drawer/model/app_drawer_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AppDrawerRepository>()])
import 'app_drawer_state_notifier.test.mocks.dart';


void main() {
  group('AppDrawerStateNotifier', () {
    late AppDrawerStateNotifier appDrawerStateNotifier;
    late AppDrawerRepository appDrawerRepository;

    setUp(() {
      appDrawerRepository = MockAppDrawerRepository();
      appDrawerStateNotifier = AppDrawerStateNotifier(appDrawerRepository);
    });

    test('should emit an app drawer state', () {
      expect(appDrawerStateNotifier.state, const AppDrawerState());
    });

    group('signOut', () {
      test('should call repository\'s signOut method',() {
        appDrawerStateNotifier.signOut();
        verify(appDrawerRepository.signOut());
      });
    });
  });
}