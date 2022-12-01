import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_category/controller/book_category_page_state_notifier.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';

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
      readingStatus = ModalRoute.of(context)!.settings.arguments as BookReadingStatus;
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
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 25), child: Consumer(builder: (_, WidgetRef ref, __) {
        final state = ref.watch(bookCategoryPageStateNotifierProvider);
        return state.map(initial: (_) => SizedBox(), inProgress: (_) => SizedBox(), successful: (_) => SizedBox(), error: (_) => SizedBox());
      },)),
    );
  }
}
