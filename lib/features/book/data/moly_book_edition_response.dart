import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/moly_book_edition.dart';

part 'moly_book_edition_response.freezed.dart';
part 'moly_book_edition_response.g.dart';

@freezed
class MolyBookEditionResponse with _$MolyBookEditionResponse{
  const factory MolyBookEditionResponse(List<MolyBookEdition> editions) = _MolyBookEditionResponse;

  factory MolyBookEditionResponse.fromJson(Map<String, Object?> json) => _$MolyBookEditionResponseFromJson(json);
}