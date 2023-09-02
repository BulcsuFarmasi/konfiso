import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_category/view/pages/book_category_page.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state_notifier.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_in_progress.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_loading_error.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_loading_success.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_saving_error.dart';
import 'package:konfiso/features/book/book_home/view/pages/book_home_page.dart';
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
      final industryIdsByType =
          ModalRoute.of(context)!.settings.arguments as Map<IndustryIdentifierType, BookIndustryIdentifier>;
      _isInit = false;
      Future(() {
        final bookDetailStateNotifier = ref.read(bookDetailPageStateNotifierProvider.notifier);
        bookDetailStateNotifier.loadBook(industryIdsByType);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(bookDetailPageStateNotifierProvider, (_, next) {
      switch (next) {
        case SavingSuccess savingSuccess:
          ref.read(bookDetailPageStateNotifierProvider.notifier).restoreToInitial();

          final navigator = Navigator.of(context);

          navigator.popUntil(ModalRoute.withName(BookHomePage.routeName));

          navigator.pushNamed(BookCategoryPage.routeName, arguments: savingSuccess.bookReadingStatus);
        default:
      }
    });
    final state = ref.watch(bookDetailPageStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: switch (state) {
              LoadingInProgress() => const BookDetailInProgress(),
              LoadingSuccess loadingSuccess => BookDetailLoadingSuccess(
                  bookReadingDetail: loadingSuccess.bookReadingDetail,
                ),
              LoadingError() => const BookDetailLoadingError(),
              SavingInProgress() => const BookDetailInProgress(),
              SavingError savingError => BookDetailSavingError(bookReadingDetail: savingError.bookReadingDetail),
              _ => const SizedBox()
            }),
      ),
    );
  }
}
