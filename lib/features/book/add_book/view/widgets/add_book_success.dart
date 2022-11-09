import 'package:flutter/material.dart';

import 'package:konfiso/features/book/add_book/view/widgets/add_book_search.dart';
import 'package:konfiso/features/book/model/book.dart';

class AddBookSuccess extends StatelessWidget {
  const AddBookSuccess({super.key, required this.books, required this.search});

  final List<Book> books;
  final AddBookSearch search;

  @override
  Widget build(BuildContext context) {
    print(books);
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(leading: Image.network(books[index].coverImageSmall!),);
            },
            itemCount: books.length,
          ),
        ),
      ],
    );
  }
}
