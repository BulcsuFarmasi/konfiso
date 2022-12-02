import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';

part 'book_detail_page_state.freezed.dart';

@freezed
class BookDetailPageState with _$BookDetailPageState {
  const factory BookDetailPageState.initial() = _Initial;

  const factory BookDetailPageState.loadingInProgress() = _LoadingInProgress;

  const factory BookDetailPageState.loadingSuccess(BookReadingDetail bookReadingDetail) = _LoadingSuccess;

  const factory BookDetailPageState.loadingError() = _LoadingError;

  const factory BookDetailPageState.savingInProgress() = _SavingInProgress;

  const factory BookDetailPageState.savingSuccess(BookReadingStatus bookReadingStatus) = _SavingSuccess;

  const factory BookDetailPageState.savingError(BookReadingDetail bookReadingDetail) = _SavingError;
}
