// import 'package:flutter_test/flutter_test.dart';
// import 'package:konfiso/shared/connection_watcher.dart';
// import 'package:konfiso/shared/services/connection_service.dart';
//
// import 'package:mocktail/mocktail.dart';
//
// class MockConnectionWatcher extends Mock implements ConnectionWatcher {}
//
// void main() {
//   group('ConnectionService', () {
//     late ConnectionService connectionService;
//     late ConnectionWatcher connectionWatcher;
//
//     setUp(() {
//       connectionWatcher = MockConnectionWatcher();
//       connectionService = ConnectionService(connectionWatcher);
//     });
//   });
//
//   void arrangeInternetConnectionCheckerOnStatusChangeEmitsConnected() {
//     when(() =>  connectionWatcher.)
//         .thenAnswer((_) => Stream.fromIterable([InternetConnectionStatus.connected]));
//   }
//
//   void arrangeInternetConnectionCheckerOnStatusChangeEmitDisconnected() {
//     when(() => internetConnectionChecker.onStatusChange)
//         .thenAnswer((_) => Stream.fromIterable([InternetConnectionStatus.disconnected]));
//   }
//
//   group('watchConnection', () {
//     test('should emit true if internet connection checker returns with true', () {
//       // arrange true
//       arrangeInternetConnectionCheckerOnStatusChangeEmitsConnected();
//       // check emit true
//       expect(connectionWatcher.watchConnection, emitsInOrder([true]));
//     });
//     test('should emit false if internet connection checker returns with false', () {
//       // arrange true
//
//       arrangeInternetConnectionCheckerOnStatusChangeEmitDisconnected();
//       // check emit true
//       expect(connectionWatcher.watchConnection, emitsInOrder([false]));
//     });
//   });
// });
// }
