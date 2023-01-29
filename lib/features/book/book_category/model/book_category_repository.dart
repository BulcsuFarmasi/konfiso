import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/stored_book.dart';
import 'package:konfiso/features/book/data/stored_book_reading_detail.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/capabiliities/isbn_from_industry_ids_capability.dart';

final bookCategoryRepositoryProvider = Provider((Ref ref) => BookCategoryRepository(ref.read(bookServiceProvider)));

class BookCategoryRepository with IsbnFromIndustryIdsCapability {
  BookCategoryRepository(this._bookService);

  final BookService _bookService;

  Stream<List<Book>> loadBooksByReadingStatus(BookReadingStatus bookReadingStatus) async* {
    final storedBooks = await _bookService.loadBooksByReadingStatusFromStorage(bookReadingStatus);

    final books = _convertStoredBooksIntoBooks(storedBooks);
    yield books;

    final remoteIsbns = await _bookService.loadIsbnByReadingStatusFromRemote(bookReadingStatus);


    yield _deleteBooksDeletedFromRemote(books, remoteIsbns);

    await for (Book newBook in _loadNewlyAddedBooks(books, remoteIsbns)) {
      books.add(newBook);
      yield books;
    }

    for (int i = 0; i < storedBooks.length; i++) {
      if (storedBooks[i].validUntil.isBefore(DateTime.now())) {
        final book = await _updateBook(storedBooks[i].isbn);
        if (book != null) {
          books[i] = book;
          yield books;
        }
      }
    }
  }

  Future<void> selectBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) async {
    final isbn = getIsbnFromIndustryIds(industryIdsByType);
    await _bookService.loadBookFromBookReadings(isbn);
  }

  void deleteBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) {
    final isbn = getIsbnFromIndustryIds(industryIdsByType);

    _bookService.deleteBookByIsbn(isbn);
  }

  List<Book> _convertStoredBooksIntoBooks(List<StoredBook> storedBooks) {
    return storedBooks
        .map(
          (StoredBook storedBook) => Book(
            title: storedBook.title,
            industryIdsByType: storedBook.industryIdsByType,
            authors: storedBook.authors,
            coverImage: CoverImage(smaller: storedBook.coverImage?.smaller),
          ),
        )
        .toList();
  }

  List<Book> _deleteBooksDeletedFromRemote(List<Book> books, List<String> remoteIsbns) {
    final remoteIsbnSet = Set.from(remoteIsbns);

    books.removeWhere((Book book) {
      final notContains = !remoteIsbnSet.contains(book.isbn);

      if (notContains) {
        _bookService.deleteBookFromStorage(book.isbn);
      }

      return notContains;
    });

    return books;
  }

  Stream<Book> _loadNewlyAddedBooks(List<Book> books, List<String> remoteIsbns) async* {
    final bookIsbns = Set.from(books.map((Book book) => book.isbn));

    remoteIsbns.retainWhere((String isbn) => !bookIsbns.contains(isbn));


    for (String remoteIsbn in remoteIsbns) {
      final book = await _updateBook(remoteIsbn);


      if (book != null) {
        yield book;
      }
    }
  }

  Future<Book?> _updateBook(String isbn) async {
    final volume = await _bookService.loadBookByIsbnFromRemote(isbn);

    final bookReadingDetail = await _bookService.loadBookReadingDetailByIsbn(isbn);

    Book? book;

    if (volume != null) {
      book = _convertVolumeToBook(volume);


      _bookService.saveBookToStorage(
        BookReadingDetail(
          book: book,
          status: bookReadingDetail?.status ?? BookReadingStatus.wantToRead,
          currentPage: bookReadingDetail?.currentPage,
          rating: bookReadingDetail?.rating,
        ),
      );
    }


      return book;
  }

  Book _convertVolumeToBook(Volume volume) => Book(
        title: volume.volumeInfo.title,
        authors: volume.volumeInfo.authors,
        coverImage: CoverImage(
          smallest: volume.volumeInfo.imageLinks?.smallThumbnail,
          smaller: volume.volumeInfo.imageLinks?.thumbnail,
          small: volume.volumeInfo.imageLinks?.thumbnail,
        ),
        industryIdsByType: volume.volumeInfo.industryIdentifiers != null
            ? {
                for (VolumeIndustryIdentifier volumeIndustryIdentifier in volume.volumeInfo.industryIdentifiers!)
                  IndustryIdentifierType.fromString(volumeIndustryIdentifier.type): BookIndustryIdentifier(
                      IndustryIdentifierType.fromString(volumeIndustryIdentifier.type),
                      volumeIndustryIdentifier.identifier)
              }
            : null,
      );
}
