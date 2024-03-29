import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/shared/capabiliities/isbn_from_industry_ids_capability.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
class Book with _$Book, IsbnFromIndustryIdsCapability {
  const Book._();

  const factory Book(
      {required String title,
      List<String>? authors,
      // represented in String to avoid conversions

      String? publicationYear,
      Map<IndustryIdentifierType, BookIndustryIdentifier>? industryIdsByType,
      CoverImage? coverImage}) = _Book;

  factory Book.fromJson(Map<String, Object?> json) => _$BookFromJson(json);

  String get isbn => getIsbnFromIndustryIds(industryIdsByType ?? {});
}

@freezed
class CoverImage with _$CoverImage {
  const factory CoverImage({
    String? smallest,
    String? smaller,
    String? small,
    String? large,
    String? larger,
    String? largest,
  }) = _CoverImage;

//
  factory CoverImage.fromJson(Map<String, Object?> json) => _$CoverImageFromJson(json);
}
