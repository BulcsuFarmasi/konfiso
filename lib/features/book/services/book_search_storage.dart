import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/stored_book.dart';
import 'package:konfiso/shared/storage.dart';

final bookSearchStorageProvider = Provider(
  (Ref ref) => BookSearchStorage(
    ref.read(
      storageProviderFamily('search'),
    ),
  ),
);

class BookSearchStorage {
  BookSearchStorage(this._storage);

  final Storage _storage;

  void saveSearchResult(List<StoredBook> storedBooks) {
    for (StoredBook storedBook in storedBooks) {
      _storage.write(storedBook.isbn, storedBook);
    }
  }

  Future<StoredBook> loadStoredBook(String isbn) async {
    return (await _storage.read(isbn)) as StoredBook;
  }

  Future<void> deleteSearchResult() async {
    _storage.deleteAll();
  }
}
