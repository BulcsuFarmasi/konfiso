import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/settings/data/stored_settings.dart';
import 'package:konfiso/shared/storage.dart';

final Provider<SettingsStorage> settingsStorageProvider = Provider<SettingsStorage>((Ref ref) => SettingsStorage(ref.read(storageProviderFamily('settings'))));

class SettingsStorage {
  SettingsStorage(this._storage);

  final Storage _storage;

  Future<StoredSettings?> loadSettings() async {
      return (await _storage.read(_storage.storageName)) as StoredSettings?;
  }

  Future<void> saveSettings(StoredSettings storedSettings) async {
    await _storage.write(_storage.storageName, storedSettings);
  }
}