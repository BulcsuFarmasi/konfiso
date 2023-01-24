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
import 'package:konfiso/shared/storage.dart';

final bookDetailRepositoryProvider = Provider((Ref ref) => BookDetailRepository(ref.read(bookServiceProvider)));

class BookDetailRepository with IsbnFromIndustryIdsCapability {
  BookDetailRepository(this._bookService);

  final BookService _bookService;

  Stream<BookReadingDetail> loadBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) async* {
    final selectedBookReadingDetail = await _bookService.loadSelectedBook();

    final isbn = getIsbnFromIndustryIds(industryIdsByType);
    //
    // final bookReadingDetail = await _bookService.loadBookReadingDetailByIsbn(isbn);

    if (selectedBookReadingDetail != null && selectedBookReadingDetail.book.validUntil.isAfter(DateTime.now())) {
      yield BookReadingDetail(
        status: selectedBookReadingDetail.status,
        currentPage: selectedBookReadingDetail.currentPage,
        rating: selectedBookReadingDetail.rating,
        comment: selectedBookReadingDetail.comment,
        book: Book(
            title: selectedBookReadingDetail.book.title,
            authors: selectedBookReadingDetail.book.authors,
            publicationYear: selectedBookReadingDetail.book.publicationYear,
            coverImage: CoverImage(
                smallest: selectedBookReadingDetail.book.coverImage?.smallest,
                smaller: selectedBookReadingDetail.book.coverImage?.smaller,
                small: selectedBookReadingDetail.book.coverImage?.small,
                large: selectedBookReadingDetail.book.coverImage?.large,
                larger: selectedBookReadingDetail.book.coverImage?.larger,
                largest: selectedBookReadingDetail.book.coverImage?.largest),
            industryIdsByType: selectedBookReadingDetail.book.industryIdsByType),
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

        // yield BookReadingDetail(
        //   status: selectedBookReadingDetail.status ?? BookReadingStatus.wantToRead,
        //   currentPage: selectedBookReadingDetailcurrentPage,
        //   rating: selectedBookReadingDetailrating,
        //   comment: selectedBookReadingDetailcomment,
        //   book: Book(
        //       title: volume.volumeInfo.title,
        //       authors: volume.volumeInfo.authors,
        //       publicationYear: publicationYear,
        //       coverImage: CoverImage(small: volume.volumeInfo.imageLinks?.small),
        //       industryIdsByType: bookIndustryIdsByType),
        // );
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
