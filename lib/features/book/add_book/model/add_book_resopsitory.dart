import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/add_book_exception.dart';
import 'package:konfiso/features/book/data/api_book.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/moly_book.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';
import 'package:string_similarity/string_similarity.dart';

final addBookRepositoryProvider = Provider((Ref ref) => AddBookRepository(ref.read(bookServiceProvider)));

class AddBookRepository {
  final BookService _bookService;

  AddBookRepository(this._bookService);

  Future<List<Book>> search(String searchTerm) async {
    if (searchTerm.trim().isEmpty) {
      return [];
    }

    try {
      List<ApiBook> apiBooks = await _bookService.search(searchTerm);

      //
      // duplikátumok szűrése

      final books = apiBooks.map((ApiBook apiBook) {
        if (apiBook is Volume) {
          return _convertVolumeToBook(apiBook);
        } else {
          return _convertMolyBookIntoBook(apiBook as MolyBook);
        }
      }).toList();

      _filterBooks(books);

      _sortBooks(books, searchTerm);

      return books;
    } on NetworkException {
      throw AddBookException();
    }
  }

  Book _convertVolumeToBook(Volume volume) => Book(
        title: volume.volumeInfo.title,
        authors: volume.volumeInfo.authors,
        coverImage: CoverImage(smallest: volume.volumeInfo.imageLinks?.smallThumbnail),
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

    return Book(
        title: molyBook.title,
        authors: molyBook.author.split(' - '),
        coverImage: CoverImage(smallest: molyBook.cover),
        publicationYear: molyBook.year.toString(),
        industryIdsByType: industryIdsByType);
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

    for (Map<int, Book> mathcingBook in matchingBooks) {
      final matchingBookEntries = mathcingBook.entries;
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
