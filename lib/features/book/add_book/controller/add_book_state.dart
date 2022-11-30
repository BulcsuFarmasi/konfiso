import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/book.dart';

part 'add_book_state.freezed.dart';

@freezed
class AddBookPageState with _$AddBookPageState {
  const factory AddBookPageState.initial() = _Initial;

  const factory AddBookPageState.inProgress() = _InProgress;

  const factory AddBookPageState.successful(List<Book> books) = _Successful;

  const factory AddBookPageState.error() = _Error;
}
