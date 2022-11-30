import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_data.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_reading_detail_form.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookDetailSavingError extends StatelessWidget {
  const BookDetailSavingError({
    required this.book,
    required this.bookReadingDetail,
    super.key,
  });

  final Book book;
  final BookReadingDetail bookReadingDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookData(book: book),
        const SizedBox(
          height: 20,
        ),
        Text(
          AppLocalizations.of(context)!.couldntSaveTheReadingPleaseTryAgain,
          style: const TextStyle(color: AppColors.primaryColor, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        BookReadingDetailForm(book: book, bookReadingDetail: bookReadingDetail),
      ],
    );
  }
}
