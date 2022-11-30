import 'package:flutter/material.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookDetailLoadingError extends StatelessWidget {
  const BookDetailLoadingError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.couldntLoadTheBookPleaseTryAgain,
        style: const TextStyle(color: AppColors.primaryColor, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
