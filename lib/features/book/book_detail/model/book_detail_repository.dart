import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_detail_loading_excpetion.dart';
import 'package:konfiso/features/book/data/book_detail_saving_exception.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/capabiliities/isbn_from_industry_ids_capability.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final bookDetailRepositoryProvider = Provider((Ref ref) => BookDetailRepository(ref.read(bookServiceProvider)));

class BookDetailRepository with IsbnFromIndustryIdsCapability {
  BookDetailRepository(this._bookService);

  final BookService _bookService;

  Stream<BookReadingDetail> loadBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) async* {
    final selectedBook = await _bookService.loadSelectedBook();

    final isbn = getIsbnFromIndustryIds(industryIdsByType);

    final bookReadingDetail = await _bookService.loadBookReadingDetailByIsbn(isbn);

    if (selectedBook != null && selectedBook.validUntil.isAfter(DateTime.now())) {
      print(selectedBook);
      yield BookReadingDetail(
        status: bookReadingDetail?.status ?? BookReadingStatus.wantToRead,
        currentPage: bookReadingDetail?.currentPage,
        rating: bookReadingDetail?.rating,
        comment: bookReadingDetail?.comment,
        book: Book(
            title: selectedBook.title,
            authors: selectedBook.authors,
            publicationYear: selectedBook.publicationYear,
            coverImage: CoverImage(
                smallest: selectedBook.coverImage?.smallest,
                smaller: selectedBook.coverImage?.smaller,
                small: selectedBook.coverImage?.small,
                large: selectedBook.coverImage?.large,
                larger: selectedBook.coverImage?.larger,
                largest: selectedBook.coverImage?.largest),
            industryIdsByType: selectedBook.industryIdsByType),
      );
    } else {
      //
      //  _bookService.selectBookByIsbn(isbn);

      _bookService.loadBookByIsbn(isbn);

      final volumes = _bookService.loadBookByIsbn(isbn);

      await for (Volume? volume in volumes) {
        // try {
        if (volume == null) {
          throw BookDetailLoadingException();
        }

        final publicationYear = volume.volumeInfo.publishedDate?.split('-').first;

        final bookIndustryIdsByType = volume.volumeInfo.industryIdentifiers != null
            ? {
                for (VolumeIndustryIdentifier volumeIndustryIdentifier in volume.volumeInfo.industryIdentifiers!)
                  IndustryIdentifierType.fromString(volumeIndustryIdentifier.type): BookIndustryIdentifier(
                      IndustryIdentifierType.fromString(volumeIndustryIdentifier.type),
                      volumeIndustryIdentifier.identifier)
              }
            : null;

        yield BookReadingDetail(
          status: bookReadingDetail?.status ?? BookReadingStatus.wantToRead,
          currentPage: bookReadingDetail?.currentPage,
          rating: bookReadingDetail?.rating,
          comment: bookReadingDetail?.comment,
          book: Book(
              title: volume.volumeInfo.title,
              authors: volume.volumeInfo.authors,
              publicationYear: publicationYear,
              coverImage: CoverImage(small: volume.volumeInfo.imageLinks?.small),
              industryIdsByType: bookIndustryIdsByType),
        );
      }
      // on NetworkException catch (_) {
      //   throw BookDetailLoadingException();
      // }
    }
  }

  Future<void> saveBook(BookReadingDetail bookReadingDetail) async {
    try {
      await _bookService.saveBook(bookReadingDetail);
    } on NetworkException catch (_) {
      throw BookDetailSavingException();
    }
  }
}
