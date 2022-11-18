import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/model/industry_identifier.dart';

part 'book.freezed.dart';

@freezed
class Book with _$Book {
  const factory Book({
    String? id,
    required String title,
    required String externalId,
    List<String>? authors,
    // represented in String to avoid conversions
    String? publicationYear,
    List<BookIndustryIdentifier>? industryIds,
    String? coverImageSmall,
    String? coverImageLarge,
  }) = _Book;
}
