import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/connection_watcher.dart';

final connectionServiceProvider = Provider((Ref ref) => ConnectionService(ref.read(connectionWatcherProvider)));

class ConnectionService {
  ConnectionService(this._connectionWatcher);

  final ConnectionWatcher _connectionWatcher;

  Stream<bool> get watchConnection => _connectionWatcher.watchConnection;

  Future<bool> checkInitialConnection() async {
    return _connectionWatcher.checkInitialConnection();
  }
}
