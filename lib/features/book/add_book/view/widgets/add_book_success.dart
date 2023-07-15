import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/add_book/view/widgets/book_list_tile.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/shared/app_colors.dart';

class AddBookSuccess extends ConsumerWidget {
  const AddBookSuccess({super.key, required this.books, required this.searchTerm});

  final List<Book> books;
  final String searchTerm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = ref.read(appColorsProvider);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: appColors.inputBackgroundColor, borderRadius: BorderRadius.circular(9)),
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        child: books.isNotEmpty
            ? ListView.builder(
                itemCount: books.length,
                itemBuilder: (_, int index) {
                  return BookListTile(
                    book: books[index],
                    searchTerm: searchTerm,
                  );
                })
            : Text(
                AppLocalizations.of(context)!.noBooksFound,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
