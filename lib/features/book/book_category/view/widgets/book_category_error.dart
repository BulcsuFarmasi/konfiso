import 'package:flutter/material.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookCategoryError extends StatelessWidget {
  const BookCategoryError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.thereAreNoBooksInThisCategoryCurrentlyAddSome,
      style: const TextStyle(color: AppColors.primaryColor, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
