import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/book_category/controller/book_category_page_state.dart';
import 'package:konfiso/features/book/book_category/model/book_category_repository.dart';
import 'package:konfiso/features/book/data/book_category_loading.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';

final bookCategoryPageStateNotifierProvider =
    StateNotifierProvider<BookCategoryPageStateNotifier, BookCategoryPageState>(
        (Ref ref) => BookCategoryPageStateNotifier(ref.read(bookCategoryRepositoryProvider)));

class BookCategoryPageStateNotifier extends StateNotifier<BookCategoryPageState> {
  BookCategoryPageStateNotifier(this._bookCategoryRepository) : super(const BookCategoryPageState.initial());

  final BookCategoryRepository _bookCategoryRepository;

  void loadBooks(BookReadingStatus bookReadingStatus) {
    _bookCategoryRepository
        .loadBooksByReadingStatus(bookReadingStatus)
        .listen((BookCategoryLoading bookCategoryLoading) {
      state = BookCategoryPageState.inProgress(bookCategoryLoading);
      if (bookCategoryLoading.currentBookNumber == bookCategoryLoading.totalBookNumber) {
        state = BookCategoryPageState.successful(bookCategoryLoading.books);
      }
    });
  }
}
