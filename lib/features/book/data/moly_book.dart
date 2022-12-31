import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/api_book.dart';

part 'moly_book.freezed.dart';

part 'moly_book.g.dart';

@freezed
class MolyBook with _$MolyBook implements ApiBook {
  const factory MolyBook(
      {required int id,
      required String author,
      required String title,
      String? isbn,
      int? year,
      String? cover}) = _MolyBook;

  factory MolyBook.fromJson(Map<String, Object?> json) => _$MolyBookFromJson(json);
}
