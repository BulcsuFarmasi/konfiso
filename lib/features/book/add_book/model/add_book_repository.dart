import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/add_book_exception.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/model_book.dart';
import 'package:konfiso/features/book/data/moly_book.dart';
import 'package:konfiso/features/book/data/stored_book.dart';
import 'package:konfiso/features/book/data/stored_search_result.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/capabiliities/isbn_from_industry_ids_capability.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';
import 'package:string_similarity/string_similarity.dart';

final addBookRepositoryProvider = Provider((Ref ref) => AddBookRepository(ref.read(bookServiceProvider)));

class AddBookRepository with IsbnFromIndustryIdsCapability {
  final BookService _bookService;

  AddBookRepository(this._bookService);

  Future<List<Book>> search(String searchTerm) async {
    if (searchTerm.trim().isEmpty) {
      return [];
    }

    final searchResult = await _bookService.loadSearchResult(searchTerm);

    if (searchResult != null && searchResult.validUntil.isAfter(DateTime.now())) {
      return searchResult.books.map(_convertStoredBookToBook).toList();
    } else {
      try {
        List<ModelBook> apiBooks = await _bookService.search(searchTerm);

        final books = apiBooks.map((ModelBook apiBook) {
          if (apiBook is Volume) {
            return _convertVolumeToBook(apiBook);
          } else {
            return _convertMolyBookIntoBook(apiBook as MolyBook);
          }
        }).toList();

        _filterBooks(books);

        _sortBooks(books, searchTerm);

        final storedSearchResult = _convertBooksIntoStoredSearchResult(books, searchTerm);

        _bookService.saveSearchResult(storedSearchResult);

        return books;
      } on NetworkException {
        throw AddBookException();
      }
    }
  }

  Future<void> selectBook(
      Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType, String searchTerm) async {
    await _bookService.selectBook(industryIdsByType, searchTerm);
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

  Book _convertMolyBookIntoBook(MolyBook molyBook) {
    Map<IndustryIdentifierType, BookIndustryIdentifier>? industryIdsByType;

    if (molyBook.isbn == null) {
      industryIdsByType = null;
    } else if (molyBook.isbn!.length == 13) {
      industryIdsByType = {
        IndustryIdentifierType.isbn13: BookIndustryIdentifier(IndustryIdentifierType.isbn13, molyBook.isbn!)
      };
    } else if (molyBook.isbn!.length == 10) {
      industryIdsByType = {
        IndustryIdentifierType.isbn13: BookIndustryIdentifier(IndustryIdentifierType.isbn10, molyBook.isbn!)
      };
    } else {
      industryIdsByType = null;
    }

    final smallCover = molyBook.cover;
    final bigCover = smallCover?.replaceAll('/normal/', '/big/');

    return Book(
        title: molyBook.title,
        authors: molyBook.author.split(' - '),
        coverImage: CoverImage(
          smallest: smallCover,
          smaller: bigCover,
          small: bigCover,
        ),
        publicationYear: molyBook.year.toString(),
        industryIdsByType: industryIdsByType);
  }

  Book _convertStoredBookToBook(StoredBook storedBook) {
    return Book(
      title: storedBook.title,
      authors: storedBook.authors,
      publicationYear: storedBook.publicationYear,
      industryIdsByType: storedBook.industryIdsByType,
      coverImage: CoverImage(
        smallest: storedBook.coverImage?.smallest,
        smaller: storedBook.coverImage?.smaller,
        small: storedBook.coverImage?.small,
        large: storedBook.coverImage?.large,
        larger: storedBook.coverImage?.larger,
        largest: storedBook.coverImage?.largest,
      ),
    );
  }

  StoredSearchResult _convertBooksIntoStoredSearchResult(List<Book> books, String searchTerm) {
    final storageValidUntil = DateTime.now().add(const Duration(days: 3));
    final storedBooks = books
        .map(
          (Book book) => StoredBook(
            title: book.title,
            authors: book.authors,
            publicationYear: book.publicationYear,
            industryIdsByType: book.industryIdsByType,
            coverImage: StoredCoverImage(
              smallest: book.coverImage?.smallest,
              smaller: book.coverImage?.smaller,
              small: book.coverImage?.small,
              large: book.coverImage?.large,
              larger: book.coverImage?.larger,
              largest: book.coverImage?.largest,
            ),
            validUntil: storageValidUntil,
          ),
        )
        .toList();
    return StoredSearchResult(storedBooks, storageValidUntil, searchTerm);
  }

  void _filterBooks(List<Book> books) {
    _filterNoIsbns(books);
    _filterDuplicates(books);
  }

  void _filterNoIsbns(List<Book> books) {
    books.retainWhere((Book book) {
      return book.industryIdsByType != null &&
          (book.industryIdsByType![IndustryIdentifierType.isbn13] != null ||
              book.industryIdsByType![IndustryIdentifierType.isbn10] != null);
    });
  }

  void _filterDuplicates(List<Book> books) {
    final industryIdsTypes = books.map((Book book) => book.industryIdsByType).toList();

    List<Map<int, Book>> matchingBooks = [];

    int i = 0;
    for (int j = i + 1; i < industryIdsTypes.length; j++) {
      if (j >= industryIdsTypes.length) {
        i++;
        j = i + 1;
      } else if (_isIndustryIdsTypeMatching(industryIdsTypes[i], industryIdsTypes[j])) {
        matchingBooks.add({i: books[i], j: books[j]});
      }
    }

    for (Map<int, Book> matchingBook in matchingBooks) {
      final matchingBookEntries = matchingBook.entries;
      books[matchingBookEntries.first.key] = Book(
        title: matchingBookEntries.first.value.title,
        authors: matchingBookEntries.first.value.authors ?? matchingBookEntries.last.value.authors,
        coverImage: matchingBookEntries.first.value.coverImage ?? matchingBookEntries.last.value.coverImage,
        industryIdsByType:
            matchingBookEntries.first.value.industryIdsByType ?? matchingBookEntries.last.value.industryIdsByType,
      );

      books.remove(matchingBookEntries.last.value);
    }
  }

  bool _isIndustryIdsTypeMatching(Map<IndustryIdentifierType, BookIndustryIdentifier>? aIndustryIdsByType,
      Map<IndustryIdentifierType, BookIndustryIdentifier>? bIndustryIdsType) {
    if (aIndustryIdsByType == null || bIndustryIdsType == null) {
      return false;
    }

    if ((aIndustryIdsByType[IndustryIdentifierType.isbn13] != null &&
            bIndustryIdsType[IndustryIdentifierType.isbn13] != null) &&
        (aIndustryIdsByType[IndustryIdentifierType.isbn13]!.identifier ==
            bIndustryIdsType[IndustryIdentifierType.isbn13]!.identifier)) {
      return true;
    }

    if ((aIndustryIdsByType[IndustryIdentifierType.isbn10] != null &&
            bIndustryIdsType[IndustryIdentifierType.isbn10] != null) &&
        (aIndustryIdsByType[IndustryIdentifierType.isbn10]!.identifier ==
            bIndustryIdsType[IndustryIdentifierType.isbn10]!.identifier)) {
      return true;
    }

    return false;
  }

  void _sortBooks(List<Book> books, String searchTerm) {
    books.sort(
      (Book aBook, Book bBook) => bBook.title.similarityTo(searchTerm).compareTo(
            aBook.title.similarityTo(searchTerm),
          ),
    );
  }
}
