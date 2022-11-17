import 'package:flutter/material.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_data.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_reading_detail_form.dart';
import 'package:konfiso/features/book/model/book.dart';

class BookDetailSuccess extends StatelessWidget {
  const BookDetailSuccess({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookData(book: book),
        const BookReadingDetailForm(),
      ],
    );
  }
}
