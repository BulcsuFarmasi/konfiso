import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state.dart';
import 'package:konfiso/features/book/book_detail/model/book_detail_repository.dart';
import 'package:konfiso/features/book/data/book_detail_saving_exception.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';

final bookDetailPageStateNotifierProvider = StateNotifierProvider<BookDetailPageStateNotifier, BookDetailPageState>(
    (Ref ref) => BookDetailPageStateNotifier(ref.read(bookDetailRepositoryProvider)));

class BookDetailPageStateNotifier extends StateNotifier<BookDetailPageState> {
  BookDetailPageStateNotifier(this._bookDetailRepository) : super(const BookDetailPageState.initial());

  final BookDetailRepository _bookDetailRepository;

  void loadBookByIndustryIds(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) async {
    state = const BookDetailPageState.loadingInProgress();

    _bookDetailRepository.loadBookByIndustryIds(industryIdsByType).listen((BookReadingDetail bookReadingDetail) {
      state = BookDetailPageState.loadingSuccess(bookReadingDetail);
    }).onError((_) {
      if (state == const BookDetailPageState.initial()) {
        state = const BookDetailPageState.loadingError();
      }
    });
  }

  void saveBook(BookReadingDetail bookReadingDetail) async {
    try {
      state = const BookDetailPageState.savingInProgress();

      await _bookDetailRepository.saveBook(bookReadingDetail);

      state = BookDetailPageState.savingSuccess(bookReadingDetail.status);
    } on BookDetailSavingException catch (_) {
      state = BookDetailPageState.savingError(bookReadingDetail);
    }
  }

  void restoreToInitial() {
    state = const BookDetailPageState.initial();
  }
}
