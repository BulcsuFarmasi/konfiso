import 'package:flutter/material.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_search.dart';

class AddBookInProgress extends StatelessWidget {
  const AddBookInProgress({super.key, required this.search});

  final AddBookSearch search;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 10,
        ),
        CircularProgressIndicator(),
      ],
    );
  }
}
