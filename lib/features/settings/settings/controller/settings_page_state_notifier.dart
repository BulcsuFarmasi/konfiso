import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/settings/data/settings.dart';
import 'package:konfiso/features/settings/settings/controller/settings_page_state.dart';
import 'package:konfiso/features/settings/settings/model/settings_repository.dart';

final StateNotifierProvider<SettingsPageStateNotifier, SettingsPageState> settingsPageStateNotifierProvider =
    StateNotifierProvider<SettingsPageStateNotifier, SettingsPageState>(
        (Ref ref) => SettingsPageStateNotifier(ref.read(settingsRepositoryProvider)));

class SettingsPageStateNotifier extends StateNotifier<SettingsPageState> {
  SettingsPageStateNotifier(this._settingsRepository) : super(const SettingsPageState.initial()) {
    loadSettings();
  }

  final SettingsRepository _settingsRepository;

  void loadSettings() async {
    state = const SettingsPageState.inProgress();

    final Settings settings = await _settingsRepository.loadSettings();

    state = SettingsPageState.loadSuccess(settings);
  }

  void saveSettings(Settings settings) async {
    state = const SettingsPageState.inProgress();

    await _settingsRepository.saveSettings(settings);

    state = SettingsPageState.saveSuccess(settings);
  }
}
