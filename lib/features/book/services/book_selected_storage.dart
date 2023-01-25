import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/stored_book_reading_detail.dart';
import 'package:konfiso/shared/storage.dart';

final bookSelectedStorageProvider = Provider(
  (Ref ref) => BookSelectedStorage(
    ref.read(
      storageProviderFamily('selectedBook'),
    ),
  ),
);

class BookSelectedStorage {
  BookSelectedStorage(this._storage);

  final Storage _storage;

  Future<void> saveSelectedBook(StoredBookReadingDetail book) async {
    await _storage.write(_storage.storageName, book);
  }

  Future<StoredBookReadingDetail?> loadSelectedBook() async {
    return (await _storage.read(_storage.storageName)) as StoredBookReadingDetail?;
  }
}
