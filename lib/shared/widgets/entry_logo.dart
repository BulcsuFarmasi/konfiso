import 'package:flutter/material.dart';
import 'package:konfiso/shared/app_colors.dart';


class EntryLogo extends StatelessWidget {
  const EntryLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'K',
      style: TextStyle(
          fontSize: 100,
          fontFamily: 'Arial MT Rounded',
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w700),
    );
  }
}