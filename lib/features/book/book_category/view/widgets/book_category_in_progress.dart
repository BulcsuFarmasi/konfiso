import 'package:flutter/material.dart';
import 'package:konfiso/features/book/book_category/view/widgets/book_grid.dart';
import 'package:konfiso/features/book/data/book_category_loading.dart';

class BookCategoryInProgress extends StatelessWidget {
  const BookCategoryInProgress({super.key, required this.bookCategoryLoading});

  final BookCategoryLoading bookCategoryLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BookGrid(books: bookCategoryLoading.books),
        ),
        CircularProgressIndicator(value: bookCategoryLoading.currentBookNumber / bookCategoryLoading.totalBookNumber),
      ],
    );
  }
}
