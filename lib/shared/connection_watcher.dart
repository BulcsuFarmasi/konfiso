import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:konfiso/shared/providers/internet_connection_checker_provider.dart';
import 'package:rxdart/subjects.dart';

final connectionWatcherProvider = Provider((Ref ref) => ConnectionWatcher(ref.read(internetConnectionCheckerProvider)));

class ConnectionWatcher {
  ConnectionWatcher(this._internetConnectionChecker) {
    _checkInitialConnection();
    _watchConnection();
  }

  Stream<bool> get watchConnection => _watchConnectionController.stream;

  final InternetConnectionChecker _internetConnectionChecker;
  final _watchConnectionController = ReplaySubject<bool>();

  void _checkInitialConnection() async {
    _watchConnectionController.add(await _internetConnectionChecker.hasConnection);
  }

  void _watchConnection() {
    _internetConnectionChecker.onStatusChange.listen((InternetConnectionStatus status) {
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
