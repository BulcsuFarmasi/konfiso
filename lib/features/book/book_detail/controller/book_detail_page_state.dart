import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/book.dart';

part 'book_detail_page_state.freezed.dart';

@freezed
class BookDetailPageState with _$BookDetailPageState {
  const factory BookDetailPageState.initial() = _Initial;
  const factory BookDetailPageState.inProgress() = _InProgress;
  const factory BookDetailPageState.success(Book book) = _Success;
  const factory BookDetailPageState.error() = _Error;

}