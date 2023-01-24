import 'package:hive/hive.dart';
import 'package:konfiso/features/book/data/stored_book.dart';

part 'stored_search_result.g.dart';

@HiveType(typeId: 7)
class StoredSearchResult {
  StoredSearchResult(this.books, this.validUntil, this.searchTerm);

  @HiveField(0)
  final List<StoredBook> books;
  @HiveField(1)
  final DateTime validUntil;
  @HiveField(2)
  final String searchTerm;
}
