import 'package:flutter/material.dart';
import 'package:konfiso/features/settings/data/settings.dart';
import 'package:konfiso/features/settings/settings/view/widgets/settings_form.dart';

class SettingsSuccess extends StatelessWidget {
  const SettingsSuccess({super.key, required this.settings});

  final Settings settings;

  @override
  Widget build(BuildContext context) {
    return SettingsForm(settings);
  }
}
