import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state.dart';

final bookDetailPageStateNotifierProvider =
StateNotifierProvider<BookDetailPageStateNotifer, BookDetailPageState>(
        (Ref ref) => BookDetailPageStateNotifer());

class BookDetailPageStateNotifer extends StateNotifier<BookDetailPageState> {
  BookDetailPageStateNotifer() : super(const BookDetailPageState.initial());


  void loadBookByExternalId(String externalId) {
    state = const BookDetailPageState.inProgress();
  }
}
