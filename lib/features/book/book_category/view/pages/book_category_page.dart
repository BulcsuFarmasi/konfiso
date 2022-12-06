import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getReadingStatusDisplayText(readingStatus, context)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Consumer(
          builder: (_, WidgetRef ref, __) {
            final state = ref.watch(bookCategoryPageStateNotifierProvider);
            return state.map(
                initial: (_) => const BookCategoryInitial(),
                inProgress: (inProgress) => BookCategoryInProgress(bookCategoryLoading: inProgress.bookCategoryLoading),
                successful: (successful) => BookCategorySuccessful(books: successful.books),
                error: (_) => const BookCategoryError());
          },
        ),
      ),
    );
  }
}
