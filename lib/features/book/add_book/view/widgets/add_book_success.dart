import 'package:flutter/material.dart';
import 'package:konfiso/features/book/model/book.dart';
import 'package:konfiso/shared/app_colors.dart';

class AddBookSuccess extends StatelessWidget {
  const AddBookSuccess({super.key, required this.books});

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.inputBackgroundColor,
            borderRadius: BorderRadius.circular(9)),
        child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (_, int index) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child:
                      Image.network(books[index].coverImageSmall!, width: 40),
                ),
                title: Text(
                  books[index].title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greyDarkestColor),
                ),
                subtitle: Text(
                  books[index].authors?.join(', ') ?? '',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyDarkestWithHalfOpacity),
                ),
                trailing: ElevatedButton(
                  child: const Text('Details'),
                  onPressed: () {},
                ),
              );
            }),
      ),
    );
  }
}
