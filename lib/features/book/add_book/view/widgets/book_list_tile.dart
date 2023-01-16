import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_page_state_notifier.dart';
import 'package:konfiso/features/book/book_detail/view/pages/book_detail_page.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookListTile extends ConsumerWidget {
  const BookListTile({
    super.key,
    required this.book,
  });

  final Book book;

  void _navigateToDetailPage(
    BuildContext context,
    WidgetRef ref,
    Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType,
  ) async {
    final navigator = Navigator.of(context);
    await ref.read(addBookPageStateNotifierProvider.notifier).selectBookByIndustryIds(industryIdsByType);
    navigator.pushNamed(BookDetailPage.routeName, arguments: industryIdsByType);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: book.coverImage?.smallest != null
          ? FadeInImage(
              placeholder: const AssetImage('assets/images/no_book_cover.png'),
              image: NetworkImage(book.coverImage!.smallest!),
              width: 40,
            )
          : Image.asset(
              'assets/images/no_book_cover.png',
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
        onPressed: book.industryIdsByType != null
            ? () {
                _navigateToDetailPage(context, ref, book.industryIdsByType!);
              }
            : null,
        child: Text(AppLocalizations.of(context)!.add),
      ),
    );
  }
}
