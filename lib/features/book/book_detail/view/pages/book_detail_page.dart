import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state_notifier.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_in_progress.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_success.dart';
import 'package:konfiso/features/book/data/book_ids.dart';

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
      final bookIds = ModalRoute.of(context)!.settings.arguments as BookIds?;
      if (bookIds != null) {
        bookExternalId = bookIds.externalId!;
        _isInit = false;
        Future(() {
          final bookDetailStateNotifier =
              ref.read(bookDetailPageStateNotifierProvider.notifier);
          bookDetailStateNotifier.loadBookByExternalId(bookExternalId!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookDetailPageStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: state.map(
              initial: (_) => const SizedBox(),
              inProgress: (_) => const BookDetailInProgress(),
              success: (success) => BookDetailSuccess(book: success.book),
              error: (_) => const SizedBox()),
        ),
      ),
    );
  }
}
