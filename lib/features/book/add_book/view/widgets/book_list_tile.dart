import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/book/book_detail/view/pages/book_detail_page.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookListTile extends StatelessWidget {
  const BookListTile({
    super.key,
    required this.book,
  });

  final Book book;

  void _navigateToDetailPage(
      BuildContext context, Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) {
    Navigator.of(context).pushNamed(BookDetailPage.routeName, arguments: industryIdsByType);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: book.coverImage?.smallest != null
          ? Image.network(book.coverImage!.smallest!, width: 40)
          : Image.asset(
              'assets/images/no_book_cover.gif',
              width: 40,
            ),
      title: Text(
        book.title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.greyDarkestColor),
      ),
      subtitle: Text(
        book.authors?.join(', ') ?? '',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.greyDarkestWithHalfOpacity),
      ),
      trailing: ElevatedButton(
        onPressed: book.industryIdsByType != null ?  () {
          _navigateToDetailPage(context, book.industryIdsByType!);
        } : null,
        child: Text(AppLocalizations.of(context)!.add),
      ),
    );
  }
}
