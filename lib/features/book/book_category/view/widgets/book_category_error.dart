import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookCategoryError extends StatelessWidget {
  const BookCategoryError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.couldntLoadTheBooksForThisCategory,
      style: const TextStyle(color: AppColors.primaryColor, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
