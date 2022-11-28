import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/connection_watcher.dart';

final connectionServiceProvider = Provider((Ref ref) => ConnectionService(ref.read(connectionWatcherProvider)));

class ConnectionService {
  ConnectionService(this._connectionWatcher) {
    _watchConnection();
  }

  Stream<bool> get watchConnection => _watchConnectionController.stream;

  final ConnectionWatcher _connectionWatcher;

  final _watchConnectionController = StreamController<bool>();

  void _watchConnection() {
    _connectionWatcher.watchConnection.listen((bool connection) {
      _watchConnectionController.add(connection);
    });
  }
}
