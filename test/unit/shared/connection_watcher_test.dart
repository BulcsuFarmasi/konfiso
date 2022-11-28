import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:konfiso/shared/connection_watcher.dart';

import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  group('ConnectionWatcher', () {
    late ConnectionWatcher connectionWatcher;
    late InternetConnectionChecker internetConnectionChecker;

    setUp(() {
      internetConnectionChecker = MockInternetConnectionChecker();
      connectionWatcher = ConnectionWatcher(internetConnectionChecker);
    });

    void arrangeInternetConnectionCheckerOnStatusChangeEmitsConnected() {
      when(() => internetConnectionChecker.onStatusChange)
          .thenAnswer((_) => Stream.fromIterable([InternetConnectionStatus.connected]));
    }

    void arrangeInternetConnectionCheckerOnStatusChangeEmitDisconnected() {
      when(() => internetConnectionChecker.onStatusChange)
          .thenAnswer((_) => Stream.fromIterable([InternetConnectionStatus.disconnected]));
    }

    group('watchConnection', () {
      test('should emit true if internet connection checker returns with true', () {
        // arrange true
        arrangeInternetConnectionCheckerOnStatusChangeEmitsConnected();
        // check emit true
        expect(connectionWatcher.watchConnection, emitsInOrder([true]));
      });
      test('should emit false if internet connection checker returns with false', () {
        // arrange true

        arrangeInternetConnectionCheckerOnStatusChangeEmitDisconnected();
        // check emit true
        expect(connectionWatcher.watchConnection, emitsInOrder([false]));
      });
    });
  });
}
