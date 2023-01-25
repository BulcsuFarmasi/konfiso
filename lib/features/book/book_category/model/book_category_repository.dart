import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/stored_book.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/capabiliities/isbn_from_industry_ids_capability.dart';

final bookCategoryRepositoryProvider = Provider((Ref ref) => BookCategoryRepository(ref.read(bookServiceProvider)));

class BookCategoryRepository with IsbnFromIndustryIdsCapability {
  BookCategoryRepository(this._bookService);

  final BookService _bookService;

  Stream<List<Book>> loadBooksByReadingStatus(BookReadingStatus bookReadingStatus) async* {
    final storedBooks = await _bookService.loadBooksByReadingStatusFromStorage(bookReadingStatus);
    final books = storedBooks
        .map(
          (StoredBook storedBook) => Book(
            title: storedBook.title,
            industryIdsByType: storedBook.industryIdsByType,
            authors: storedBook.authors,
            coverImage: CoverImage(smaller: storedBook.coverImage?.smaller),
          ),
        )
        .toList();

    yield books;

    final remoteIsbns = await _bookService.loadIsbnByReadingStatusFromRemote(bookReadingStatus);

    print(remoteIsbns);
    
    // delete not existing ones
    // add existing ones
    // add them to list
  }

  Future<void> selectBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) async {
    final isbn = getIsbnFromIndustryIds(industryIdsByType);
    await _bookService.selectBookFromBookReadings(isbn);
  }

  void deleteBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) {
    final isbn = getIsbnFromIndustryIds(industryIdsByType);

    _bookService.deleteBookByIsbn(isbn);
  }
}
