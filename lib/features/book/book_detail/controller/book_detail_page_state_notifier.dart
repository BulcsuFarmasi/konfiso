import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state.dart';
import 'package:konfiso/features/book/book_detail/model/book_detail_repository.dart';

final bookDetailPageStateNotifierProvider = StateNotifierProvider<
        BookDetailPageStateNotifier, BookDetailPageState>(
    (Ref ref) =>
        BookDetailPageStateNotifier(ref.read(bookDetailRepositoryProvider)));

class BookDetailPageStateNotifier extends StateNotifier<BookDetailPageState> {
  BookDetailPageStateNotifier(this._bookDetailRepository)
      : super(const BookDetailPageState.initial());

  final BookDetailRepository _bookDetailRepository;

  void loadBookByExternalId(String externalId) async {
    state = const BookDetailPageState.inProgress();

    final book = await _bookDetailRepository.loadBookByExternalId(externalId);
    state = BookDetailPageState.success(book);
  }
}
