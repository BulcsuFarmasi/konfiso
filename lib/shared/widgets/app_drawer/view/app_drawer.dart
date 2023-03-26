import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/settings/settings/view/pages/settings_page.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:konfiso/shared/widgets/app_drawer/controller/app_drawer_state_notifier.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = Navigator.of(context);
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              'Konfiso',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: AppColors.primaryColor),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () {
              navigator.pop();
              navigator.pushReplacementNamed(SettingsPage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(AppLocalizations.of(context)!.logout),
            onTap: () {
              ref.read(appDrawerControllerProvider).signOut();
              navigator.pop();
              navigator.pushReplacementNamed('/');
            },
          )
        ],
      ),
    );
  }
}
