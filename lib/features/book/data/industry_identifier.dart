import 'package:freezed_annotation/freezed_annotation.dart';

part 'industry_identifier.freezed.dart';

part 'industry_identifier.g.dart';

@freezed
class BookIndustryIdentifier with _$BookIndustryIdentifier {
  const factory BookIndustryIdentifier(
      IndustryIdentifierType type, String identifier) = _BookIndustryIdentifier;
}

@JsonSerializable()
class VolumeIndustryIdentifier {
  final String type;
  final String identifier;

  const VolumeIndustryIdentifier(this.type, this.identifier);

  factory VolumeIndustryIdentifier.fromJson(Map<String, dynamic> json) =>
      _$VolumeIndustryIdentifierFromJson(json);
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
