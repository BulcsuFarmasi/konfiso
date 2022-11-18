import 'package:freezed_annotation/freezed_annotation.dart';

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
    List<String>? industryIds,
    String? coverImageSmall,
    String? coverImageLarge,
  }) = _Book;
}
