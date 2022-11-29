import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/services/book_service.dart';

final bookDetailRepositoryProvider = Provider((Ref ref) => BookDetailRepository(ref.read(bookServiceProvider)));

class BookDetailRepository {
  BookDetailRepository(this._bookService);

  final BookService _bookService;

  Future<Book> loadBookByIndustryIds(List<BookIndustryIdentifier> industryIds) async {
    final isbn = _getIsbnFromIndustryIds(industryIds);

    final volume = await _bookService.loadBookByIsbn(isbn);

    final publicationYear = volume.volumeInfo.publishedDate?.split('-').first;

    return Book(
      title: volume.volumeInfo.title,
      authors: volume.volumeInfo.authors,
      publicationYear: publicationYear,
      coverImageLarge: volume.volumeInfo.imageLinks?.small,
      industryIds: volume.volumeInfo.industryIdentifiers!
          .map((VolumeIndustryIdentifier industryIdentifier) => BookIndustryIdentifier(
              IndustryIdentifierType.fromString(industryIdentifier.type), industryIdentifier.identifier))
          .toList(),
    );
  }

  Future<void> saveBook(List<BookIndustryIdentifier> industryIds, BookReadingDetail bookReadingDetail) async {
    final isbn = _getIsbnFromIndustryIds(industryIds);

    await _bookService.saveBook(isbn, bookReadingDetail);
  }

  String _getIsbnFromIndustryIds(List<BookIndustryIdentifier> industryIds) {
    return industryIds
        .firstWhere(
            (BookIndustryIdentifier industryIdentifier) => industryIdentifier.type == IndustryIdentifierType.isbn13,
            orElse: () => industryIds.firstWhere((BookIndustryIdentifier industryIdentifier) =>
                industryIdentifier.type == IndustryIdentifierType.isbn10))
        .identifier;
  }
}
