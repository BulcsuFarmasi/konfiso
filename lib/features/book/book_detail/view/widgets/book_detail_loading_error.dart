import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookDetailLoadingError extends ConsumerWidget {
  const BookDetailLoadingError({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = ref.read(appColorsProvider);
    return Center(
      child: Text(
        AppLocalizations.of(context)!.couldntLoadTheBookPleaseTryAgain,
        style: TextStyle(color: appColors.primaryColor, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
