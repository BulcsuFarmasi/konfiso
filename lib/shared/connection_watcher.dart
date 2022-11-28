import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionWatcher {
  ConnectionWatcher(this._internetConnectionChecker) {
    _watchConnection();
  }

  Stream<bool> get watchConnection => _watchConnectionController.stream;

  final InternetConnectionChecker _internetConnectionChecker;
  final StreamController<bool> _watchConnectionController = StreamController<bool>();

  void _watchConnection() {
    _internetConnectionChecker.onStatusChange.listen((InternetConnectionStatus status) {
      print(status);
      switch (status) {
        case InternetConnectionStatus.connected:
          _watchConnectionController.add(true);
          break;
        case InternetConnectionStatus.disconnected:
          _watchConnectionController.add(false);
          break;
      }
    });
  }
}
