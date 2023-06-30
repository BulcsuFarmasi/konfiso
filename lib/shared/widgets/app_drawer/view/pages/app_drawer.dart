import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/book/book_home/view/pages/book_home_page.dart';
import 'package:konfiso/features/settings/settings/view/pages/settings_page.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:konfiso/shared/widgets/app_drawer/data/app_drawer_list_item.dart';
import 'package:konfiso/shared/widgets/app_drawer/view/widgets/app_drawer_list_item.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<AppDrawerListItem>? listItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    listItems ??= [
      AppDrawerListItem(AppDrawerListItemType.signOut, Icons.exit_to_app, AppLocalizations.of(context)!.logout, '/'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Text(
              'Konfiso',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: AppColors.primaryColor),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, int index) {
                return AppDrawerListTile(appDrawerListItem: listItems![index]);
              },
              itemCount: listItems!.length,
            ),
          ),
        ],
      ),
    );
  }
}
