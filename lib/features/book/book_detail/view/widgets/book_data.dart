import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookData extends ConsumerWidget {
  const BookData({required this.book, super.key});

  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = ref.read(appColorsProvider);
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        book.coverImage?.small != null
            ? CachedNetworkImage(
                imageUrl: book.coverImage!.small!,
                placeholder: (context, url) => Image.asset('assets/images/no_book_cover.png'),
                errorWidget: (context, url, error) => Image.asset('assets/images/no_book_cover.png'),
                width: 215,
              )
            : Image.asset(
                'assets/images/no_book_cover.png',
                width: 215,
              ),
        const SizedBox(
          height: 30,
        ),
        Text(
          book.title,
          style: TextStyle(fontSize: 24, color: appColors.greyDarkestColor, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Visibility(
          visible: book.authors != null,
          child: Text(
            book.authors?.join(', ') ?? '',
            style:
                TextStyle(fontSize: 14, color: appColors.greyDarkestWithHalfOpacity, fontWeight: FontWeight.w500),
          ),
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
                style: TextStyle(fontSize: 14, color: appColors.greyDarkestColor, fontWeight: FontWeight.w600),
              ),
              Text(book.publicationYear ?? ''),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.isbn,
              style: TextStyle(fontSize: 14, color: appColors.greyDarkestColor, fontWeight: FontWeight.w600),
            ),
            Text(book.industryIdsByType!.values
                .map((BookIndustryIdentifier industryIdentifier) => industryIdentifier.identifier)
                .join(', ')),
          ],
        ),
      ],
    );
  }
}
