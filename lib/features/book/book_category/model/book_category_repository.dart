import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/capabiliities/isbn_from_industry_ids_capability.dart';

final bookCategoryRepositoryProvider = Provider((Ref ref) => BookCategoryRepository(ref.read(bookServiceProvider)));

class BookCategoryRepository with IsbnFromIndustryIdsCapability {
  BookCategoryRepository(this._bookService);

  final BookService _bookService;

  Stream<List<Book>> loadBooksByReadingStatus(BookReadingStatus bookReadingStatus) {
    List<Book> books = [];
    BookReadingStatus? currentBookReadingStatus;
    return _bookService.loadBooksByReadingStatus(bookReadingStatus).map((List<Volume> volumes) {
      return volumes.map((Volume volume) {
        final industryIdsByType = {
          for (VolumeIndustryIdentifier volumeIndustryIdentifier in volume.volumeInfo.industryIdentifiers!)
            IndustryIdentifierType.fromString(volumeIndustryIdentifier.type): BookIndustryIdentifier(
                IndustryIdentifierType.fromString(volumeIndustryIdentifier.type), volumeIndustryIdentifier.identifier)
        };

        return Book(
            title: volume.volumeInfo.title,
            industryIdsByType: industryIdsByType,
            authors: volume.volumeInfo.authors,
            coverImage: CoverImage(
              smaller: volume.volumeInfo.imageLinks?.thumbnail,
            ));
      }).toList();
    });
    // return _bookService.watchVolumeCategoryLoading.handleError((_) {
    //   throw BookCategoryException();
    // }).map((VolumeCategoryLoading volumeCategoryLoading) {
    //   if (volumeCategoryLoading.currentVolume != null) {
    //     if (currentBookReadingStatus == null || bookReadingStatus != currentBookReadingStatus) {
    //       books = [];
    //       currentBookReadingStatus = bookReadingStatus;
    //     }
    //
    //     int bookIndex = (volume.volumeIndex! < 0)
    //         ? 0
    //         : volume.volumeIndex!;
    //     bookIndex = (bookIndex >= volumeCategoryLoading.totalVolumeNumber) ? bookIndex - 1 : bookIndex;
    //
    //     if (bookIndex >= books.length) {
    //       books.add(book);
    //     } else {
    //       books[bookIndex] = book;
    //     }
    //   }
    //
    //   return BookCategoryLoading(
    //       books: books,
    //       currentBookNumber: volumeCategoryLoading.currentVolumeNumber,
    //       totalBookNumber: volumeCategoryLoading.totalVolumeNumber);
    // });
  }

  Future<void> selectBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) async {
    final isbn = getIsbnFromIndustryIds(industryIdsByType);
    await _bookService.selectBookFromBookReadings(isbn);
  }

  void deleteBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) {
    final isbn = getIsbnFromIndustryIds(industryIdsByType);

    _bookService.deleteBookByIsbn(isbn);
  }
}
