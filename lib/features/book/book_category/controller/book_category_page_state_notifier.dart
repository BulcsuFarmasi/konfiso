import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_category/controller/book_category_page_state.dart';
import 'package:konfiso/features/book/book_category/model/book_category_repository.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';

final bookCategoryPageStateNotifierProvider =
StateNotifierProvider<BookCategoryPageStateNotifier, BookCategoryPageState>(
        (Ref ref) => BookCategoryPageStateNotifier(ref.read(bookCategoryRepositoryProvider)));

class BookCategoryPageStateNotifier extends StateNotifier<BookCategoryPageState> {
  BookCategoryPageStateNotifier(this._bookCategoryRepository) : super(const BookCategoryPageState.initial());

  final BookCategoryRepository _bookCategoryRepository;
  StreamSubscription? loadBooksSubscription;

  void loadBooks(BookReadingStatus bookReadingStatus) {
    state = const BookCategoryPageState.inProgress();
    loadBooksSubscription = _bookCategoryRepository.loadBooksByReadingStatus(bookReadingStatus)
    //     .handleError((_) {
    //   state = const BookCategoryPageState.error();
    // })
        .listen((List<Book> books) {
      state = BookCategoryPageState.successful(books);
    });
  }

  Future<void> selectBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) async {
    await _bookCategoryRepository.selectBook(industryIdsByType);
  }

  void deleteBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdByType) {
    _bookCategoryRepository.deleteBook(industryIdByType);

    switch (state) {
      case InProgress inProgress:
        state = inProgress;
      case Succesful successful:
        final books = _deleteBookFromList(successful.books, industryIdByType);
        state = successful.copyWith(books: books);
      default:
        const BookCategoryPageState.initial()
    }
  }

  List<Book> _deleteBookFromList(List<Book> books,
      Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsType) {
    final bookIndex = books.indexWhere((Book book) => book.industryIdsByType == industryIdsType);
    return [...books.sublist(0, bookIndex), ...books.sublist(bookIndex + 1)];
  }

  void restoreToInitial() {
    state = const BookCategoryPageState.initial();
    loadBooksSubscription?.cancel();
  }
}
