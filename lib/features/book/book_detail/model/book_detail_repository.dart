import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_detail_loading_excpetion.dart';
import 'package:konfiso/features/book/data/book_detail_saving_exception.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/remote_book_reading_detail.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final bookDetailRepositoryProvider = Provider((Ref ref) => BookDetailRepository(ref.read(bookServiceProvider)));

class BookDetailRepository {
  BookDetailRepository(this._bookService);

  final BookService _bookService;

  Future<BookReadingDetail> loadBookByIndustryIds(List<BookIndustryIdentifier> industryIds) async {
    final isbn = _getIsbnFromIndustryIds(industryIds);

    try {
      final volume = await _bookService.loadBookByIsbn(isbn);
      final bookReadingDetail = await _bookService.loadBookReadingDetailByIsbn(isbn);

      final publicationYear = volume.volumeInfo.publishedDate?.split('-').first;

      return BookReadingDetail(
          status: bookReadingDetail?.status ?? BookReadingStatus.wantToRead,
          currentPage: bookReadingDetail?.currentPage,
          rating: bookReadingDetail?.rating,
          comment: bookReadingDetail?.comment,
          book: Book(
              title: volume.volumeInfo.title,
              authors: volume.volumeInfo.authors,
              publicationYear: publicationYear,
              coverImageLarge: volume.volumeInfo.imageLinks?.small,
              industryIds: volume.volumeInfo.industryIdentifiers!
                  .map((VolumeIndustryIdentifier industryIdentifier) => BookIndustryIdentifier(
                      IndustryIdentifierType.fromString(industryIdentifier.type), industryIdentifier.identifier))
                  .toList()));
    } on NetworkException catch (_) {
      throw BookDetailLoadingException();
    }
  }

  Future<void> saveBook(BookReadingDetail bookReadingDetail) async {
    try {
      final isbn = _getIsbnFromIndustryIds(bookReadingDetail.book!.industryIds);

      final remoteBookReadingDetail = RemoteBookReadingDetail(
        status: bookReadingDetail.status,
        currentPage: bookReadingDetail.currentPage,
        rating: bookReadingDetail.rating,
        comment: bookReadingDetail.comment,
      );

      await _bookService.saveBook(isbn, remoteBookReadingDetail);
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
