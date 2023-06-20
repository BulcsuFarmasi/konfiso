import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/settings/data/settings.dart';
import 'package:konfiso/features/settings/services/services/setting_service.dart';
import 'package:konfiso/features/settings/data/stored_settings.dart';

final Provider<SettingsRepository> settingsRepositoryProvider =
    Provider<SettingsRepository>((Ref ref) => SettingsRepository(ref.read(settingsServiceProvider)));

class SettingsRepository {
  SettingsRepository(this._settingsService);

  final SettingsService _settingsService;

  Future<Settings> loadSettings() async {
    final StoredSettings? storedSettings = await _settingsService.loadSettings();

    return Settings(storedSettings?.darkMode ?? false);
  }

  Future<void> saveSettings(Settings settings) async {
    await _settingsService.saveSettings(StoredSettings(settings.darkMode));
  }
}
