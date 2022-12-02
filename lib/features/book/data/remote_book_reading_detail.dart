import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';

part 'remote_book_reading_detail.freezed.dart';
part 'remote_book_reading_detail.g.dart';

@freezed
class RemoteBookReadingDetail with _$RemoteBookReadingDetail {
  const factory RemoteBookReadingDetail(
      {required BookReadingStatus status, int? currentPage, double? rating, String? comment}) = _BookReadingDetail;

  factory RemoteBookReadingDetail.fromJson(Map<String, Object?> json) => _$RemoteBookReadingDetailFromJson(json);
}
