import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/shared/app_colors.dart';

class AddBookError extends StatelessWidget {
  const AddBookError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      Intl.message('An error occured, couldn\'t load books'),
      style: const TextStyle(color: AppColors.primaryColor, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
