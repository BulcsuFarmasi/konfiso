import 'package:flutter/material.dart';
import 'package:konfiso/features/book/book_category/view/widgets/book_grid.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/shared/app_colors.dart';

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
        : const Text(
            'There are no books currently in this category',
            style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
            textAlign: TextAlign.center,
          );
  }
}
