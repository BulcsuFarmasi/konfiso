import 'package:flutter/material.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_data.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_reading_detail_form.dart';
import 'package:konfiso/features/book/data/book.dart';

class BookDetailLoadingSuccess extends StatelessWidget {
  const BookDetailLoadingSuccess({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookData(book: book),
        const SizedBox(
          height: 20,
        ),
        BookReadingDetailForm(
          book: book,
        ),
      ],
    );
  }
}
