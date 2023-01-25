import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'industry_identifier.freezed.dart';

part 'industry_identifier.g.dart';

@freezed
class BookIndustryIdentifier with _$BookIndustryIdentifier {
  @HiveType(typeId: 3, adapterName: 'BookIndustryIdentifierAdapter')
  const factory BookIndustryIdentifier(
    @HiveField(0) IndustryIdentifierType type,
    @HiveField(1) String identifier,
  ) = _BookIndustryIdentifier;

  factory BookIndustryIdentifier.fromJson(Map<String, Object?> json) => _$BookIndustryIdentifierFromJson(json);
}

@freezed
class VolumeIndustryIdentifier with _$VolumeIndustryIdentifier {
  const factory VolumeIndustryIdentifier(String type, String identifier) = _VolumeIndustryIdentifier;

  factory VolumeIndustryIdentifier.fromJson(Map<String, Object?> json) => _$VolumeIndustryIdentifierFromJson(json);
}

@HiveType(typeId: 4)
enum IndustryIdentifierType {
  @HiveField(0)
  isbn13(),
  @HiveField(1)
  isbn10(),
  @HiveField(2)
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

  @override
  String toString() {
    switch (this) {
      case IndustryIdentifierType.isbn13:
        return 'ISBN_13';
      case IndustryIdentifierType.isbn10:
        return 'ISBN_10';
      case IndustryIdentifierType.other:
        return 'OTHER';
    }
  }
}
