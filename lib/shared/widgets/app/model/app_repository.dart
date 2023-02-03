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
  AppRepository(this._languageService, this._connectionService);

  final LanguageService _languageService;
  final ConnectionService _connectionService;

  Stream<bool> get watchConnection => _connectionService.watchConnection;

  void setLocale(String locale) {
    _languageService.locale = locale;
  }
}
