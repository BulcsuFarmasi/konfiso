import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_detail_loading_excpetion.dart';
import 'package:konfiso/features/book/data/book_detail_saving_exception.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/capabiliities/isbn_from_industry_ids_capability.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final bookDetailRepositoryProvider = Provider((Ref ref) => BookDetailRepository(ref.read(bookServiceProvider)));

class BookDetailRepository with IsbnFromIndustryIdsCapability {
  BookDetailRepository(this._bookService);

  final BookService _bookService;

  Future<BookReadingDetail> loadBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) async {
    final selectedBookReadingDetail = await _bookService.loadSelectedBook();

    if (selectedBookReadingDetail == null) {
      throw BookDetailLoadingException();
    }

    return BookReadingDetail(
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
  }

  Future<void> saveBook(BookReadingDetail bookReadingDetail) async {
    try {
      await _bookService.saveBook(bookReadingDetail);
    } on NetworkException catch (_) {
      throw BookDetailSavingException();
    }
  }
}
