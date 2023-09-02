import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/book.dart';

part 'book_category_page_state.freezed.dart';

@freezed
sealed class BookCategoryPageState with _$BookCategoryPageState {
  const factory BookCategoryPageState.initial() = Initial;

  const factory BookCategoryPageState.inProgress() = InProgress;

  const factory BookCategoryPageState.successful(List<Book> books) = Succesful;

  const factory BookCategoryPageState.error() = Error;
}
