import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state.dart';
import 'package:konfiso/features/book/book_detail/model/book_detail_repository.dart';
import 'package:konfiso/features/book/book_detail/view/pages/book_detail_page.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';

final bookDetailPageStateNotifierProvider = StateNotifierProvider<BookDetailPageStateNotifier, BookDetailPageState>(
    (Ref ref) => BookDetailPageStateNotifier(ref.read(bookDetailRepositoryProvider)));

class BookDetailPageStateNotifier extends StateNotifier<BookDetailPageState> {
  BookDetailPageStateNotifier(this._bookDetailRepository) : super(const BookDetailPageState.initial());

  final BookDetailRepository _bookDetailRepository;

  void loadBookByIndustryIds(List<BookIndustryIdentifier> industryIds) async {
    state = const BookDetailPageState.loadingInProgress();

    final book = await _bookDetailRepository.loadBookByIndustryIds(industryIds);

    state = BookDetailPageState.loadingSuccess(book);
  }

  void saveBook(List<BookIndustryIdentifier> industryIds, BookReadingDetail bookReadingDetail) async {
    state = const BookDetailPageState.savingInProgress();

    await _bookDetailRepository.saveBook(industryIds, bookReadingDetail);

    state = BookDetailPageState.savingSuccess(bookReadingDetail.status);
  }

  void restoreToInitial() {
    state = const BookDetailPageState.initial();
  }
}
