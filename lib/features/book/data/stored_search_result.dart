import 'package:hive/hive.dart';
import 'package:konfiso/features/book/data/stored_book_reading_detail.dart';

part 'stored_search_result.g.dart';

@HiveType(typeId: 7)
class StoredSearchResult {
  StoredSearchResult(this.bookReadingDetails, this.validUntil, this.searchTerm);

  @HiveField(0)
  final List<StoredBookReadingDetail> bookReadingDetails;
  @HiveField(1)
  final DateTime validUntil;
  @HiveField(2)
  final String searchTerm;
}
