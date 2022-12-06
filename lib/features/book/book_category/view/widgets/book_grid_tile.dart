import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/book/book_detail/view/pages/book_detail_page.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookGridTile extends StatelessWidget {
  const BookGridTile({
    super.key,
    required this.book,
  });

  final Book book;

  void _navigateToDetailPage(BuildContext context) {
    Navigator.of(context).pushNamed(BookDetailPage.routeName, arguments: book.industryIds);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: book.coverImageLarge != null
              ? Image.network(
                  book.coverImageLarge!,
                  width: 140,
                )
              : Image.asset(
                  'assets/images/no_book_cover.gif',
                  width: 140,
                ),
        ),
        Text(
          book.title,
          style: const TextStyle(fontSize: 18, color: AppColors.greyDarkestColor, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        Visibility(
          visible: book.authors != null,
          child: Text(
            book.authors?.join(', ') ?? '',
            style:
                const TextStyle(fontSize: 14, color: AppColors.greyDarkestWithHalfOpacity, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              _navigateToDetailPage(context);
            },
            child: Text(AppLocalizations.of(context)!.details))
      ],
    );
  }
}
