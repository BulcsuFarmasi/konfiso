import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_detail_loading_excpetion.dart';
import 'package:konfiso/features/book/data/book_detail_saving_exception.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final bookDetailRepositoryProvider = Provider((Ref ref) => BookDetailRepository(ref.read(bookServiceProvider)));

class BookDetailRepository {
  BookDetailRepository(this._bookService);

  final BookService _bookService;

  Future<Book> loadBookByIndustryIds(List<BookIndustryIdentifier> industryIds) async {
    final isbn = _getIsbnFromIndustryIds(industryIds);

    try {
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
              .toList());
    } on NetworkException catch (_) {
      throw BookDetailLoadingException();
    }
  }

  Future<void> saveBook(List<BookIndustryIdentifier> industryIds, BookReadingDetail bookReadingDetail) async {
    try {
      final isbn = _getIsbnFromIndustryIds(industryIds);

      await _bookService.saveBook(isbn, bookReadingDetail);
    } on NetworkException catch (_) {
      throw BookDetailSavingException();
    }
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
