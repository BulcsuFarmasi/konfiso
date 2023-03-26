import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/shared/widgets/app_drawer/view/pages/app_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _changed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Column(children: [
        Expanded(
          child: ListTile(
            title: Text(AppLocalizations.of(context)!.darkMode),
            trailing: Switch(
                value: _changed,
                onChanged: (bool? changed) {
                  setState(() {
                    _changed = changed != null && changed;
                  });
                }),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(AppLocalizations.of(context)!.save),
        )
      ]),
    );
  }
}
