import 'package:flutter/material.dart';
import 'package:konfiso/features/book/book_category/view/widgets/book_grid_tile.dart';
import 'package:konfiso/features/book/data/book.dart';

class BookGrid extends StatelessWidget {
  const BookGrid({
    Key? key,
    required this.books,
  }) : super(key: key);

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 150,
      crossAxisSpacing: 20,
      childAspectRatio: 0.275,
      children: books
          .map(
            (Book book) => BookGridTile(
              book: book,
            ),
          )
          .toList(),
    );
  }
}
