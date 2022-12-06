import 'package:flutter/material.dart';
import 'package:konfiso/features/book/book_category/view/widgets/book_grid.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookCategorySuccessful extends StatelessWidget {
  const BookCategorySuccessful({
    required this.books,
    super.key,
  });

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return (books.isNotEmpty)
        ? BookGrid(books: books)
        : Text(
            AppLocalizations.of(context)!.thereAreNoBooksInThisCategoryCurrentlyAddSome,
            style: const TextStyle(color: AppColors.primaryColor, fontSize: 20),
            textAlign: TextAlign.center,
          );
  }
}
