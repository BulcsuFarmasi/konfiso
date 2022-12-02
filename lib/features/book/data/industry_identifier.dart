import 'package:freezed_annotation/freezed_annotation.dart';

part 'industry_identifier.freezed.dart';
part 'industry_identifier.g.dart';

@freezed
class BookIndustryIdentifier with _$BookIndustryIdentifier {
  const factory BookIndustryIdentifier(IndustryIdentifierType type, String identifier) = _BookIndustryIdentifier;

  factory BookIndustryIdentifier.fromJson(Map<String, Object?> json) => _$BookIndustryIdentifierFromJson(json);
}

@freezed
class VolumeIndustryIdentifier with _$VolumeIndustryIdentifier {
  const factory VolumeIndustryIdentifier(String type, String identifier) = _VolumeIndustryIdentifier;

  factory VolumeIndustryIdentifier.fromJson(Map<String, Object?> json) => _$VolumeIndustryIdentifierFromJson(json);
}

enum IndustryIdentifierType {
  isbn13(),
  isbn10(),
  other();

  const IndustryIdentifierType();

  factory IndustryIdentifierType.fromString(String type) {
    switch (type) {
      case 'ISBN_13':
        return isbn13;
      case 'ISBN_10':
        return isbn10;
      case 'OTHER':
      default:
        return other;
    }
  }
}
