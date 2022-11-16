import 'package:flutter/material.dart';
import 'package:konfiso/features/book/book_category/view/pages/book_category_page.dart';
import 'package:konfiso/features/book/model/book_reading_status.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookHomeMenuItem extends StatelessWidget {
  const BookHomeMenuItem({super.key, required this.readingStatus});

  final BookReadingStatus readingStatus;

  void _navigateToCategoryPage(BuildContext context) {
    Navigator.of(context)
        .pushNamed(BookCategoryPage.routeName, arguments: readingStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 50),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: InkWell(
        onTap: () {
          _navigateToCategoryPage(context);
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            width: 310,
            child: Text(
              getReadingStatusDisplayText(readingStatus, context),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.greyDarkerColor,
              ),
            )),
      ),
    );
  }
}
