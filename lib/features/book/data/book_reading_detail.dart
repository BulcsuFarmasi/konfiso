import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';

part 'book_reading_detail.freezed.dart';
part 'book_reading_detail.g.dart';

@freezed
class BookReadingDetail with _$BookReadingDetail{
  const factory BookReadingDetail({required BookReadingStatus status, int? currentPage, double? rating, String? comment}) = _BookReadingDetail;

  factory BookReadingDetail.fromJson(Map<String, Object?> json) => _$BookReadingDetailFromJson(json);
}

