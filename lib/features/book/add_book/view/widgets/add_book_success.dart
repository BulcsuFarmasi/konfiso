import 'package:flutter/material.dart';
import 'package:konfiso/features/book/add_book/view/widgets/book_tile.dart';
import 'package:konfiso/features/book/model/book.dart';
import 'package:konfiso/shared/app_colors.dart';

class AddBookSuccess extends StatelessWidget {
  const AddBookSuccess({super.key, required this.books});

  final List<Book> books;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.inputBackgroundColor,
              borderRadius: BorderRadius.circular(9)),
          child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (_, int index) {
                return BookTile(book: books[index]);
              }),
        ),
      );
}
