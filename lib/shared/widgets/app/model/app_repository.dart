import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/settings/services/services/setting_service.dart';
import 'package:konfiso/shared/services/connection_service.dart';
import 'package:konfiso/shared/services/language_service.dart';

final appRepositoryProvider = Provider(
  (Ref ref) => AppRepository(
    ref.read(languageServiceProvider),
    ref.read(connectionServiceProvider),
    ref.read(settingsServiceProvider),
  ),
);

class AppRepository {
  AppRepository(this._languageService, this._connectionService, this._settingsService);

  final LanguageService _languageService;
  final ConnectionService _connectionService;
  final SettingsService _settingsService;

  Stream<bool> get watchConnection => _connectionService.watchConnection;
  Stream<bool> get watchDarkMode => _settingsService.watchDarkMode;

  void setLocale(String locale) {
    _languageService.locale = locale;
  }
}
