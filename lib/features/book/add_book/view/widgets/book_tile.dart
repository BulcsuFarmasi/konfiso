import 'package:flutter/material.dart';
import 'package:konfiso/features/book/book_detail/view/pages/book_detail_page.dart';
import 'package:konfiso/features/book/model/book.dart';
import 'package:konfiso/features/book/model/book_ids.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  void _navigateToDetailPage(BuildContext context, String externalId) {
    Navigator.of(context).pushNamed(
        BookDetailPage.routeName, arguments: BookIds(externalId: externalId));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: (book.coverImageSmall != null)
            ? Image.network(book.coverImageSmall!, width: 40)
            : Image.asset(
          'assets/images/no_book_cover.gif',
          width: 40,
        ),
      ),
      title: Text(
        book.title,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.greyDarkestColor),
      ),
      subtitle: Text(
        book.authors?.join(', ') ?? '',
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.greyDarkestWithHalfOpacity),
      ),
      trailing: ElevatedButton(
        child: const Text('Add'),
        onPressed: () {
          _navigateToDetailPage(context, book.externalId);
        },
      ),
    );
  }
}
