import 'package:flutter/material.dart';
import 'package:konfiso/features/book/%20model/book_reading_status.dart';
import 'package:konfiso/shared/app_colors.dart';

class BookHomeMenuItem extends StatelessWidget {
  const BookHomeMenuItem({super.key, required this.readingStatus});

  final BookReadingStatus readingStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 50),
        elevation: 0,
        child: InkWell(
          onTap: () {},
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              width: 310,
              child: Text(
                '$readingStatus',
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
