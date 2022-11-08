import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';

@freezed
class Book with _$Book {
  const factory Book({
    required String id,
    required String title,
    required String externalId,
    List<String>? authors,
    int? publicationYear,
    int? isbn,
    String? coverImage,
  }) = _Book;
}
