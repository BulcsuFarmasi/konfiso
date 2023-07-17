import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_data.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_reading_detail_form.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookDetailSavingError extends ConsumerWidget {
  const BookDetailSavingError({
    required this.bookReadingDetail,
    super.key,
  });

  final BookReadingDetail bookReadingDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors  = ref.read(appColorsProvider);
    return Column(
      children: [
        BookData(book: bookReadingDetail.book!),
        const SizedBox(
          height: 20,
        ),
        Text(
          AppLocalizations.of(context)!.couldntSaveTheReadingPleaseTryAgain,
          style: TextStyle(color: appColors.primaryColor, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        BookReadingDetailForm(bookReadingDetail: bookReadingDetail),
      ],
    );
  }
}
