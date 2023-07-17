import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_page_state_notifier.dart';
import 'package:konfiso/features/book/book_detail/view/pages/book_detail_page.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookListTile extends ConsumerWidget {
  const BookListTile({
    super.key,
    required this.book,
    required this.searchTerm,
  });

  final Book book;
  final String searchTerm;

  void _navigateToDetailPage(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final navigator = Navigator.of(context);
    await ref.read(addBookPageStateNotifierProvider.notifier).selectBook(book.industryIdsByType!, searchTerm);
    navigator.pushNamed(BookDetailPage.routeName, arguments: book.industryIdsByType);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = ref.read(appColorsProvider);
    return ListTile(
      leading: book.coverImage?.smallest != null
          ? CachedNetworkImage(
              imageUrl: book.coverImage!.smallest!,
              placeholder: (context, url) => Image.asset('assets/images/no_book_cover.png'),
              errorWidget: (context, url, error) => Image.asset('assets/images/no_book_cover.png'),
              width: 40,
            )
          : Image.asset(
              'assets/images/no_book_cover.png',
              width: 40,
            ),
      title: Text(
        book.title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: appColors.higherEmphasisText),
      ),
      subtitle: Text(
        book.authors?.join(', ') ?? '',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: appColors.highEmphasisText),
      ),
      trailing: FilledButton(
        onPressed: book.industryIdsByType != null
            ? () {
                _navigateToDetailPage(context, ref);
              }
            : null,
        child: Text(AppLocalizations.of(context)!.add),
      ),
    );
  }
}
