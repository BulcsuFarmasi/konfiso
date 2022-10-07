import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/shared/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              'Konfiso',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(AppColors.primaryColor)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(Intl.message('Logout')),
          )
        ],
      ),
    );
  }
}
