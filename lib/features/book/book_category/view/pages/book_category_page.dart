import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/add_book/view/pages/add_book_page.dart';
import 'package:konfiso/features/book/book_category/controller/book_category_page_state.dart';
import 'package:konfiso/features/book/book_category/controller/book_category_page_state_notifier.dart';
import 'package:konfiso/features/book/book_category/view/widgets/book_category_error.dart';
import 'package:konfiso/features/book/book_category/view/widgets/book_category_in_progress.dart';
import 'package:konfiso/features/book/book_category/view/widgets/book_category_initial.dart';
import 'package:konfiso/features/book/book_category/view/widgets/book_category_successful.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';

class BookCategoryPage extends ConsumerStatefulWidget {
  const BookCategoryPage({super.key});

  static const routeName = '/book-category';

  @override
  ConsumerState<BookCategoryPage> createState() => _BookCategoryPageState();
}

class _BookCategoryPageState extends ConsumerState<BookCategoryPage> {
  late BookReadingStatus readingStatus;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      readingStatus = ModalRoute.of(context)!.settings.arguments as BookReadingStatus;
      _isInit = false;
      Future(() {
        ref.read(bookCategoryPageStateNotifierProvider.notifier).loadBooks(readingStatus);
      });
    }
  }

  void _navigateToAddBookPage(BuildContext context) {
    Navigator.of(context).pushNamed(AddBookPage.routeName);
  }

  void _navigateBack() {
    Navigator.of(context).pop();
    ref.read(bookCategoryPageStateNotifierProvider.notifier).restoreToInitial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getReadingStatusDisplayText(readingStatus, context)),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            _navigateBack();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Consumer(
          builder: (_, WidgetRef ref, __) {
            final state = ref.watch(bookCategoryPageStateNotifierProvider);
            return switch(state) {
              Initial() => const BookCategoryInitial(),
              InProgress() => const BookCategoryInProgress(),
              Succesful successful => BookCategorySuccessful(books: successful.books),
              Error() => const BookCategoryError(),
            };
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddBookPage(context);
        },
        elevation: 0,
        child: const Icon(Icons.add),
      ),
    );
  }
}
