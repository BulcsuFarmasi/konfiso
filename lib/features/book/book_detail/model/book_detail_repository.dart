import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_detail_loading_excpetion.dart';
import 'package:konfiso/features/book/data/book_detail_saving_exception.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/remote_book_reading_detail.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final bookDetailRepositoryProvider = Provider((Ref ref) => BookDetailRepository(ref.read(bookServiceProvider)));

class BookDetailRepository {
  BookDetailRepository(this._bookService);

  final BookService _bookService;

  Stream<BookReadingDetail> loadBookByIndustryIds(
      Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) async* {
    final isbn = _getIsbnFromIndustryIds(industryIdsByType);

    _bookService.loadBookByIsbn(_getIsbnFromIndustryIds(industryIdsByType));

    final bookReadingDetail = await _bookService.loadBookReadingDetailByIsbn(isbn);

    final volumes = _bookService.loadBookByIsbn(isbn);

    await for (Volume? volume in volumes) {
      try {
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
      } on NetworkException catch (_) {
        throw BookDetailLoadingException();
      }
    }
  }

  Future<void> saveBook(BookReadingDetail bookReadingDetail) async {
    try {
      final isbn = _getIsbnFromIndustryIds(bookReadingDetail.book!.industryIdsByType!);

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

  String _getIsbnFromIndustryIds(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) {
    return (industryIdsByType[IndustryIdentifierType.isbn13]?.identifier ??
            industryIdsByType[IndustryIdentifierType.isbn10]?.identifier) ??
        '';
  }
}
