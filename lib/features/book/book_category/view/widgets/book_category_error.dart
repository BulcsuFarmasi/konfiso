import 'package:flutter/material.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookCategoryError extends StatelessWidget {
  const BookCategoryError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Couldn\'t load the books for this category',
      style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
