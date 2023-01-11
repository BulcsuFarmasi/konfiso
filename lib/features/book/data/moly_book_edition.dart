import 'package:freezed_annotation/freezed_annotation.dart';

part 'moly_book_edition.freezed.dart';

part 'moly_book_edition.g.dart';

@freezed
class MolyBookEdition with _$MolyBookEdition {
  const factory MolyBookEdition({String? isbn, int? year, String? cover, String? bookId}) = _MolyBookEdition;

  factory MolyBookEdition.fromJson(Map<String, Object?> json) => _$MolyBookEditionFromJson(json);
}
