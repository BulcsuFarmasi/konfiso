import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/stored_book_reading_detail.dart';
import 'package:konfiso/features/book/data/stored_search_result.dart';
import 'package:konfiso/shared/capabiliities/isbn_from_industry_ids_capability.dart';
import 'package:konfiso/shared/storage.dart';

final bookSearchStorageProvider = Provider(
  (Ref ref) => BookSearchStorage(
    ref.read(
      storageProviderFamily('search'),
    ),
  ),
);

class BookSearchStorage with IsbnFromIndustryIdsCapability {
  BookSearchStorage(this._storage);

  final Storage _storage;

  void saveSearchResult(StoredSearchResult storedSearchResult) {
    _storage.write(storedSearchResult.searchTerm, storedSearchResult);
  }

  Future<StoredSearchResult?> loadSearchResult(String searchTerm) async {
    return (await _storage.read(searchTerm)) as StoredSearchResult?;
  }

  Future<StoredBookReadingDetail?> loadStoredBook(
      Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType, String searchTerm) async {
    final searchResult = await loadSearchResult(searchTerm);

    return searchResult?.bookReadingDetails.firstWhere((StoredBookReadingDetail storedBookReadingDetail) =>
        storedBookReadingDetail.book.isbn == getIsbnFromIndustryIds(industryIdsByType));
  }

  Future<void> deleteSearchResult() async {
    _storage.deleteAll();
  }
}
