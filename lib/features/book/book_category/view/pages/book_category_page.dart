import 'package:flutter/material.dart';
import 'package:konfiso/features/book/model/book_reading_status.dart';

class BookCategoryPage extends StatefulWidget {
  const BookCategoryPage({super.key});

  static const routeName = '/book-category';

  @override
  State<BookCategoryPage> createState() => _BookCategoryPageState();
}

class _BookCategoryPageState extends State<BookCategoryPage> {
  late BookReadingStatus readingStatus;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      readingStatus =
          ModalRoute.of(context)!.settings.arguments as BookReadingStatus;
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getReadingStatusDisplayText(readingStatus, context)),
        centerTitle: true,
      ),
    );
  }
}
