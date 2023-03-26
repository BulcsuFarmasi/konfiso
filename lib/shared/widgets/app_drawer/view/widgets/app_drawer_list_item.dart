import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/widgets/app_drawer/controller/app_drawer_state_notifier.dart';
import 'package:konfiso/shared/widgets/app_drawer/data/app_drawer_list_item.dart';

class AppDrawerListTile extends ConsumerWidget {
  const AppDrawerListTile({
    super.key,
    required this.appDrawerListItem,
  });

  final AppDrawerListItem appDrawerListItem;

  void navigate(NavigatorState navigator, WidgetRef ref) {
    navigator.pop();
    navigator.pushReplacementNamed(appDrawerListItem.target);
    if (appDrawerListItem.type == AppDrawerListItemType.signOut) {
      ref.read(appDrawerControllerProvider).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Icon(appDrawerListItem.icon),
      title: Text(appDrawerListItem.title),
      onTap: () {
        navigate(Navigator.of(context), ref);
      },
    );
  }
}
