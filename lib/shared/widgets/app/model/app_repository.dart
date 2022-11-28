import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/services/connection_service.dart';
import 'package:konfiso/shared/services/language_service.dart';

final appRepositoryProvider = Provider(
  (Ref ref) => AppRepository(
    ref.read(languageServiceProvider),
    ref.read(connectionServiceProvider),
  ),
);

class AppRepository {
  AppRepository(this._languageService, this._connectionService) {
    _watchConnection();
  }

  Stream<bool> get watchConnection => _watchConnectionController.stream;

  final LanguageService _languageService;
  final ConnectionService _connectionService;
  final _watchConnectionController = StreamController<bool>();

  void setLocale(String locale) {
    _languageService.locale = locale;
  }

  void _watchConnection() {
    _connectionService.watchConnection.listen((connection) {
      _watchConnectionController.add(connection);
    });
  }
}
