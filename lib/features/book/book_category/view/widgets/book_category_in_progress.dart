import 'package:flutter/material.dart';

class BookCategoryInProgress extends StatelessWidget {
  const BookCategoryInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
    // return Column(
    //   children: [
    //     Expanded(
    //       child: BookGrid(books: bookCategoryLoading.books),
    //     ),
    //     CircularProgressIndicator(value: bookCategoryLoading.currentBookNumber / bookCategoryLoading.totalBookNumber),
    //   ],
    // );
  }
}
