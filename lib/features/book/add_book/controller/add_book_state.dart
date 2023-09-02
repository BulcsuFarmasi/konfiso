import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/book.dart';

part 'add_book_state.freezed.dart';

@freezed
sealed class AddBookPageState with _$AddBookPageState {
  const factory AddBookPageState.initial() = Initial;

  const factory AddBookPageState.inProgress() = InProgress;

  const factory AddBookPageState.successful(List<Book> books, String searchTerm) = Successful;

  const factory AddBookPageState.error() = Error;
}
