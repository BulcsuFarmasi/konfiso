import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/book.dart';

part 'book_category_page_state.freezed.dart';
part 'book_category_page_state.g.dart';

@freezed
class BookCategoryPageState with _BookCategoryPageState{
  const factory BookCategoryPageState.initial() = _Initial;
  const factory BookCategoryPageState.inProgress(List<Book> books, int currentBookNumber, int totalBookNumber) = _InProgress;
  const factory BookCategoryPageState.successful(List<Book> books) = _Succesful;
  const factory BookCategoryPageState.error(List<Book> books) = _Error;
}