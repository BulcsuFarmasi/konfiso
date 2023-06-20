import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/settings/data/settings.dart';
import 'package:konfiso/features/settings/settings/controller/settings_page_state_notifier.dart';

class SettingsForm extends ConsumerStatefulWidget {
  const SettingsForm(this.settings, {super.key});

  final Settings settings;

  @override
  ConsumerState<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends ConsumerState<SettingsForm> {
  late Settings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.settings;
  }

  void _changeDarkMode(bool? darkMode) {
    setState(() {
      _settings = Settings(darkMode ?? false);
    });
  }

  void _saveSettings() {
    ref.read(settingsPageStateNotifierProvider.notifier).saveSettings(_settings);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListTile(
          title: Text(AppLocalizations.of(context)!.darkMode),
          trailing: Switch(
            value: _settings.darkMode,
            onChanged: _changeDarkMode,
          ),
        ),
      ),
      ElevatedButton(
        onPressed: _saveSettings,
        child: Text(AppLocalizations.of(context)!.save),
      )
    ]);
  }
}
