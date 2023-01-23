import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_category/controller/book_category_page_state.dart';
import 'package:konfiso/features/book/book_category/model/book_category_repository.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_category_loading.dart';
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
    // loadBooksSubscription = _bookCategoryRepository.loadBooksByReadingStatus(bookReadingStatus)
    // //     .handleError((_) {
    // //   state = const BookCategoryPageState.error();
    // // })
    //     .listen((BookCategoryLoading bookCategoryLoading) {
    //   state = BookCategoryPageState.inProgress(bookCategoryLoading);
    //   if (bookCategoryLoading.currentBookNumber >= bookCategoryLoading.totalBookNumber) {
    //     state = BookCategoryPageState.successful(bookCategoryLoading.books);
    //   }
    // });
  }

  void deleteBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsType) {
    _bookCategoryRepository.deleteBook(industryIdsType);

    state = state.maybeMap(
      inProgress: (inProgress) {
        final books = _deleteBookFromList(inProgress.bookCategoryLoading.books, industryIdsType);
        return inProgress.copyWith(
            bookCategoryLoading: inProgress.bookCategoryLoading.copyWith(
          books: books,
          currentBookNumber: inProgress.bookCategoryLoading.currentBookNumber - 1,
          totalBookNumber: inProgress.bookCategoryLoading.totalBookNumber - 1,
        ));
      },
      successful: (successful) {
        final books = _deleteBookFromList(successful.books, industryIdsType);
        return successful.copyWith(books: books);
      },
      orElse: () => const BookCategoryPageState.initial(),
    );
  }

  List<Book> _deleteBookFromList(
      List<Book> books, Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsType) {
    final bookIndex = books.indexWhere((Book book) => book.industryIdsByType == industryIdsType);
    return [...books.sublist(0, bookIndex), ...books.sublist(bookIndex + 1)];
  }

  void restoreToInitial() {
    state = const BookCategoryPageState.initial();
    loadBooksSubscription?.cancel();
  }
}
