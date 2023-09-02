import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/settings/settings/controller/settings_page_state.dart';
import 'package:konfiso/features/settings/settings/controller/settings_page_state_notifier.dart';
import 'package:konfiso/features/settings/settings/view/widgets/settings_in_progress.dart';
import 'package:konfiso/features/settings/settings/view/widgets/settings_success.dart';
import 'package:konfiso/shared/widgets/app_drawer/view/pages/app_drawer.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SettingsPageState state = ref.watch(settingsPageStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),

      body: switch(state) {
        Initial() => const SizedBox(),
        InProgress() => const SettingsInProgress(),
        LoadSuccess loadSuccess => SettingsSuccess(settings: loadSuccess.settings),
        SaveSuccess saveSuccess => SettingsSuccess(settings: saveSuccess.settings),
      },
    );
  }
}
