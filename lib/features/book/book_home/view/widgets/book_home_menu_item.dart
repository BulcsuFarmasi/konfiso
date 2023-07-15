import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_category/view/pages/book_category_page.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookHomeMenuItem extends ConsumerWidget {
  const BookHomeMenuItem({super.key, required this.readingStatus});

  final BookReadingStatus readingStatus;

  void _navigateToCategoryPage(BuildContext context) {
    Navigator.of(context).pushNamed(BookCategoryPage.routeName, arguments: readingStatus);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppColors appColors = ref.read(appColorsProvider);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 50),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
        side: BorderSide(color: appColors.primaryColor, width: 1),
      ),
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
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: appColors.greyDarkestColor,
              ),
            )),
      ),
    );
  }
}
