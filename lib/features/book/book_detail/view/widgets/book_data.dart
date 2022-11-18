import 'package:flutter/material.dart';
import 'package:konfiso/features/book/model/book.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookData extends StatelessWidget {
  const BookData({required this.book, super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: book.coverImageLarge != null
              ? Image.network(
                  book.coverImageLarge!,
                  width: 215,
                )
              : Image.asset(
                  'assets/images/no_book_cover.gif',
                  width: 215,
                ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          book.title,
          style: const TextStyle(
              fontSize: 24,
              color: AppColors.greyDarkestColor,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          book.authors?.join(', ') ?? '',
          style: const TextStyle(
              fontSize: 14,
              color: AppColors.greyDarkestWithHalfOpacity,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        Visibility(
          visible: book.publicationYear != null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.publicationYear,
                style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.greyDarkestColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(book.publicationYear ?? ''),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Visibility(
          visible: book.industryIds != null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.isbn,
                style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.greyDarkestColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(book.industryIds?.join(', ') ?? ''),
            ],
          ),
        ),
      ],
    );
  }
}
