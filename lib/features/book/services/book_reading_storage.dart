import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/stored_book_reading_detail.dart';
import 'package:konfiso/shared/storage.dart';

final bookReadingStorageProvider = Provider(
  (Ref ref) => BookReadingStorage(
    ref.read(
      storageProviderFamily('bookReadings'),
    ),
  ),
);

class BookReadingStorage {
  BookReadingStorage(this._storage);

  final Storage _storage;

  Future<void> saveBookReading(StoredBookReadingDetail bookReadingDetail) async {
    _storage.write(bookReadingDetail.book.isbn, bookReadingDetail);
  }

  Future<List<StoredBookReadingDetail>> loadBookReadingDetails(BookReadingStatus bookReadingStatus) async {
    final result = await _storage.readAll();

    List<StoredBookReadingDetail> storedBookReadingDetails = [];

    if (result != null) {
      storedBookReadingDetails = result.cast<StoredBookReadingDetail>();
      storedBookReadingDetails.retainWhere(
          (StoredBookReadingDetail storedBookReadingDetail) => storedBookReadingDetail.status == bookReadingStatus);
    }

    return storedBookReadingDetails;
  }

  Future<StoredBookReadingDetail> loadStoredBook(String isbn) async {
    return ((await _storage.read(isbn)) as StoredBookReadingDetail);
  }

  Future<void> deleteBook(String isbn) async {
    await _storage.delete(isbn);
  }
}
