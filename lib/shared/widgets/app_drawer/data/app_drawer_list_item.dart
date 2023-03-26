import 'package:flutter/material.dart';

class AppDrawerListItem {
  final AppDrawerListItemType type;
  final IconData icon;
  final String title;
  final String target;

  AppDrawerListItem(this.type, this.icon, this.title, this.target);
}

enum AppDrawerListItemType {
  books,
  settings,
  signOut,
}
