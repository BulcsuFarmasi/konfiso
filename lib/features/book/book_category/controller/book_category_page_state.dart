import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/book.dart';

part 'book_category_page_state.freezed.dart';

@freezed
class BookCategoryPageState with _$BookCategoryPageState {
  const factory BookCategoryPageState.initial() = _Initial;

  const factory BookCategoryPageState.inProgress() = _InProgress;

  const factory BookCategoryPageState.successful(List<Book> books) = _Succesful;

  const factory BookCategoryPageState.error() = _Error;
}
