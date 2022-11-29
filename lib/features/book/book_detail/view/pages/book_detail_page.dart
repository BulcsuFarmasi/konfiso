import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_category/view/pages/book_category_page.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state_notifier.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_in_progress.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_success.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';

class BookDetailPage extends ConsumerStatefulWidget {
  const BookDetailPage({super.key});

  static const routeName = '/book-detail';

  @override
  ConsumerState<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends ConsumerState<BookDetailPage> {
  bool _isInit = true;
  String? bookId;
  String? bookExternalId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final industryIds = ModalRoute.of(context)!.settings.arguments as List<BookIndustryIdentifier>;
      _isInit = false;
      Future(() {
        final bookDetailStateNotifier = ref.read(bookDetailPageStateNotifierProvider.notifier);
        bookDetailStateNotifier.loadBookByIndustryIds(industryIds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(bookDetailPageStateNotifierProvider, (_, next) {
      next.maybeMap(
          savingSuccess: (savingSuccess) {
            ref.read(bookDetailPageStateNotifierProvider.notifier).restoreToInitial();
            Navigator.of(context).pushNamed(BookCategoryPage.routeName, arguments: savingSuccess.bookReadingStatus);
          },
          orElse: () => null);
    });
    final state = ref.watch(bookDetailPageStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: state.maybeMap(
            initial: (_) => const SizedBox(),
            loadingInProgress: (_) => const BookDetailInProgress(),
            loadingSuccess: (success) => BookDetailSuccess(book: success.book),
            loadingError: (_) => const SizedBox(),
            savingInProgress: (_) => const SizedBox(),
            savingSuccess: (_) => const SizedBox(),
            savingError: (_) => const SizedBox(),
            orElse: () => const SizedBox(),
          ),
        ),
      ),
    );
  }
}
