import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_category/controller/book_category_page_state_notifier.dart';
import 'package:konfiso/features/book/book_detail/view/pages/book_detail_page.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookGridTile extends ConsumerWidget {
  const BookGridTile({
    super.key,
    required this.book,
  });

  final Book book;

  void _navigateToDetailPage(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final navigator = Navigator.of(context);
    await ref.read(bookCategoryPageStateNotifierProvider.notifier).selectBook(book.industryIdsByType!);
    navigator.pushNamed(BookDetailPage.routeName, arguments: book.industryIdsByType);
  }

  void _deleteBook(BuildContext context, WidgetRef ref) {
    final navigator = Navigator.of(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.doYouWantToDeleteThisBook),
            actions: [
              TextButton(
                  onPressed: () {
                    navigator.pop();
                  },
                  child: Text(AppLocalizations.of(context)!.cancel)),
              TextButton(
                  onPressed: () {
                    ref.read(bookCategoryPageStateNotifierProvider.notifier).deleteBook(book.industryIdsByType!);
                    navigator.pop();
                  },
                  child: Text(AppLocalizations.of(context)!.delete)),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        book.coverImage?.smaller != null
            ? CachedNetworkImage(
                imageUrl: book.coverImage!.smaller!,
                placeholder: (context, url) => Image.asset('assets/images/no_book_cover.png'),
                errorWidget: (context, url, error) => Image.asset('assets/images/no_book_cover.png'),
                width: 140,
              )
            : Image.asset(
                'assets/images/no_book_cover.png',
                width: 140,
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
              _navigateToDetailPage(context, ref);
            },
            child: Text(AppLocalizations.of(context)!.details)),
        OutlinedButton(
          onPressed: () {
            _deleteBook(context, ref);
          },
          child: Text(AppLocalizations.of(context)!.delete),
        ),
      ],
    );
  }
}
