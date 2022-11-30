import 'package:flutter/material.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookDetailLoadingError extends StatelessWidget {
  const BookDetailLoadingError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Couldn\'t load the book, please try again',
        style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
