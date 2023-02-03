import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/moly_book.dart';

part 'moly_book_search_response.freezed.dart';
part 'moly_book_search_response.g.dart';

@freezed
class MolyBookSearchResponse with _$MolyBookSearchResponse {
  const factory MolyBookSearchResponse(List<MolyBook> books) = _MolyBookSearchResponse;

  factory MolyBookSearchResponse.fromJson(Map<String, Object?> json) => _$MolyBookSearchResponseFromJson(json);
}
