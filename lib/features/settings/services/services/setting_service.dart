import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/settings/services/services/settings_storage.dart';
import 'package:konfiso/features/settings/data/stored_settings.dart';
import 'package:rxdart/subjects.dart';

final Provider<SettingsService> settingsServiceProvider = Provider<SettingsService>(
      (Ref ref) =>
      SettingsService(
        ref.read(settingsStorageProvider),
      ),
);

class SettingsService {
  SettingsService(this._settingsStorage) {
    _initializeDarkMode();
  }

  final SettingsStorage _settingsStorage;

  final _watchDarkModeController = ReplaySubject<bool>();

  Stream<bool> get watchDarkMode => _watchDarkModeController.stream;

  Future<StoredSettings?> loadSettings() {
    return _settingsStorage.loadSettings();
  }

  Future<void> saveSettings(StoredSettings storedSettings) {
    _watchDarkModeController.add(storedSettings.darkMode);
    return _settingsStorage.saveSettings(storedSettings);
  }

  Future<void> _initializeDarkMode() async {
    StoredSettings? storedSettings = await loadSettings();
    print(storedSettings?.darkMode);
    _watchDarkModeController.add(storedSettings?.darkMode ?? false);
  }
}
