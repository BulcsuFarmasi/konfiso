import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookCategoryError extends ConsumerWidget {
  const BookCategoryError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = ref.read(appColorsProvider);
    return Text(
      AppLocalizations.of(context)!.couldntLoadTheBooksForThisCategory,
      style:  TextStyle(color: appColors.primaryColor, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
