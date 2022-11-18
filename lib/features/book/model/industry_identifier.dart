import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/book/model/book.dart';

part 'industry_identifier.g.dart';

abstract class IndustryIdentifier {
  final String identifier;

  const IndustryIdentifier(
    this.identifier,
  );
}

class BookIndustryIdentifier extends IndustryIdentifier {
  final IndustryIdentifierType type;

  const BookIndustryIdentifier(this.type, super.identifier);
}

@JsonSerializable()
class VolumeIndustryIdentifier extends IndustryIdentifier {
  final String type;

  const VolumeIndustryIdentifier(this.type, super.identifier);

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
