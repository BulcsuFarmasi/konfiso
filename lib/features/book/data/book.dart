import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
class Book with _$Book {
  const factory Book({
    required String title,
    List<String>? authors,
    // represented in String to avoid conversions
    String? publicationYear,
    required List<BookIndustryIdentifier> industryIds,
    String? coverImageSmall,
    String? coverImageLarge,
  }) = _Book;

  factory Book.fromJson(Map<String, Object?> json) => _$BookFromJson(json);
}
