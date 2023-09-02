import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';

part 'book_detail_page_state.freezed.dart';

@freezed
sealed class BookDetailPageState with _$BookDetailPageState {
  const factory BookDetailPageState.initial() = Initial;

  const factory BookDetailPageState.loadingInProgress() = LoadingInProgress;

  const factory BookDetailPageState.loadingSuccess(BookReadingDetail bookReadingDetail) = LoadingSuccess;

  const factory BookDetailPageState.loadingError() = LoadingError;

  const factory BookDetailPageState.savingInProgress() = SavingInProgress;

  const factory BookDetailPageState.savingSuccess(BookReadingStatus bookReadingStatus) = SavingSuccess;

  const factory BookDetailPageState.savingError(BookReadingDetail bookReadingDetail) = SavingError;
}
