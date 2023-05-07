import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/settings/services/services/settings_storage.dart';
import 'package:konfiso/features/settings/data/stored_settings.dart';

final Provider<SettingsService> settingsServiceProvider = Provider<SettingsService>(
  (Ref ref) => SettingsService(
    ref.read(settingsStorageProvider),
  ),
);

class SettingsService {
  SettingsService(this._settingsStorage);

  final SettingsStorage _settingsStorage;

  Future<StoredSettings?> loadSettings() {
    return _settingsStorage.loadSettings();
  }

  Future<void> saveSettings(StoredSettings storedSettings) {
    return _settingsStorage.saveSettings(storedSettings);
  }
}
