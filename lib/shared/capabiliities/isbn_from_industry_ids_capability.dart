import 'package:konfiso/features/book/data/industry_identifier.dart';

mixin IsbnFromIndustryIdsCapability {
  String getIsbnFromIndustryIds(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) {
    return (industryIdsByType[IndustryIdentifierType.isbn13]?.identifier ??
        industryIdsByType[IndustryIdentifierType.isbn10]?.identifier) ?? '';
  }
}