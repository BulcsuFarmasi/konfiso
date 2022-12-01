import 'package:flutter/material.dart';
import 'package:konfiso/features/book/book_category/view/widgets/book_grid.dart';
import 'package:konfiso/features/book/data/book.dart';

class BookCategorySuccessful extends StatelessWidget {
  const BookCategorySuccessful({
    required this.books,
    super.key,
  });

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return BookGrid(books: books);
  }
}
