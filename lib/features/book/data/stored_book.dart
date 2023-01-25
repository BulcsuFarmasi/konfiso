import 'package:hive/hive.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/model_book.dart';
import 'package:konfiso/shared/capabiliities/isbn_from_industry_ids_capability.dart';

part 'stored_book.g.dart';

@HiveType(typeId: 0)
class StoredBook extends ModelBook with IsbnFromIndustryIdsCapability {
  @HiveField(0)
  String title;
  @HiveField(1)
  List<String>? authors;

  // represented in String to avoid conversions
  @HiveField(2)
  String? publicationYear;
  @HiveField(3)
  Map<IndustryIdentifierType, BookIndustryIdentifier>? industryIdsByType;
  @HiveField(4)
  StoredCoverImage? coverImage;
  @HiveField(5)
  DateTime validUntil;

  StoredBook({
    required this.title,
    required this.validUntil,
    this.authors,
    this.publicationYear,
    this.industryIdsByType,
    this.coverImage,
  });

  String get isbn => getIsbnFromIndustryIds(industryIdsByType!);
}

@HiveType(typeId: 1)
class StoredCoverImage {
  @HiveField(0)
  String? smallest;
  @HiveField(1)
  String? smaller;
  @HiveField(2)
  String? small;
  @HiveField(3)
  String? large;
  @HiveField(4)
  String? largest;
  @HiveField(5)
  String? larger;

  StoredCoverImage({this.smallest, this.smaller, this.small, this.large, this.larger, this.largest});
}
