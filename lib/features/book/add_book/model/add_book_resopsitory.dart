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

      for (ApiBook apiBook in apiBooks) {
        print(apiBook.runtimeType);
      }

      //
      // duplikátumok szűrése
      // rendezáse

      final books = apiBooks.map((ApiBook apiBook) {
        if (apiBook is Volume) {
          return Book(
            title: apiBook.volumeInfo.title,
            authors: apiBook.volumeInfo.authors,
            coverImage: CoverImage(smallest: apiBook.volumeInfo.imageLinks?.smallThumbnail),
            industryIdsByType: {
              for (VolumeIndustryIdentifier volumeIndustryIdentifier in apiBook.volumeInfo.industryIdentifiers!)
                IndustryIdentifierType.fromString(volumeIndustryIdentifier.type): BookIndustryIdentifier(
                    IndustryIdentifierType.fromString(volumeIndustryIdentifier.type),
                    volumeIndustryIdentifier.identifier)
            },
          );
        } else {
          apiBook = apiBook as MolyBook;

          Map<IndustryIdentifierType, BookIndustryIdentifier>? industryIdsByType;

          print(apiBook);

          if (apiBook.isbn == null) {
            industryIdsByType = null;
          } else if (apiBook.isbn!.length == 13) {
            industryIdsByType = {
              IndustryIdentifierType.isbn13: BookIndustryIdentifier(IndustryIdentifierType.isbn13, apiBook.isbn!)
            };
          } else if (apiBook.isbn!.length == 10) {
            industryIdsByType = {
              IndustryIdentifierType.isbn13: BookIndustryIdentifier(IndustryIdentifierType.isbn10, apiBook.isbn!)
            };
          } else {
            industryIdsByType = null;
          }

          return Book(
              title: apiBook.title,
              authors: apiBook.author.split(' - '),
              coverImage: CoverImage(smallest: apiBook.cover),
              publicationYear: apiBook.year.toString(),
              industryIdsByType: industryIdsByType);
        }
      }).toList();

      books.retainWhere((Book book) {
        return book.industryIdsByType != null &&
            (book.industryIdsByType![IndustryIdentifierType.isbn13] != null ||
                book.industryIdsByType![IndustryIdentifierType.isbn10] != null);
      });

      books.sort(
        (Book aBook, Book bBook) => bBook.title.similarityTo(searchTerm).compareTo(
              aBook.title.similarityTo(searchTerm),
            ),
      );

      print(books);

      return books;
    } on NetworkException {
      throw AddBookException();
    }
  }
}
