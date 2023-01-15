import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_category_exception.dart';
import 'package:konfiso/features/book/data/book_category_loading.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/volume_category_loading.dart';
import 'package:konfiso/features/book/services/book_service.dart';

final bookCategoryRepositoryProvider = Provider((Ref ref) => BookCategoryRepository(ref.read(bookServiceProvider)));

class BookCategoryRepository {
  BookCategoryRepository(this._bookService);

  final BookService _bookService;

  Stream<BookCategoryLoading> loadBooksByReadingStatus(BookReadingStatus bookReadingStatus) {
    List<Book> books = [];
    BookReadingStatus? currentBookReadingStatus;
    _bookService.loadBooksByReadingStatus(bookReadingStatus);
    return _bookService.watchVolumeCategoryLoading.handleError((_) {
      throw BookCategoryException();
    }).map((VolumeCategoryLoading volumeCategoryLoading) {
      if (volumeCategoryLoading.currentVolume != null) {
        if (currentBookReadingStatus == null || bookReadingStatus != currentBookReadingStatus) {
          books = [];
          currentBookReadingStatus = bookReadingStatus;
        }
        final industryIdsByType = {
          for (VolumeIndustryIdentifier volumeIndustryIdentifier
              in volumeCategoryLoading.currentVolume!.volumeInfo.industryIdentifiers!)
            IndustryIdentifierType.fromString(volumeIndustryIdentifier.type): BookIndustryIdentifier(
                IndustryIdentifierType.fromString(volumeIndustryIdentifier.type), volumeIndustryIdentifier.identifier)
        };

        final book = Book(
            title: volumeCategoryLoading.currentVolume!.volumeInfo.title,
            industryIdsByType: industryIdsByType,
            authors: volumeCategoryLoading.currentVolume!.volumeInfo.authors,
            coverImage: CoverImage(
              smaller: volumeCategoryLoading.currentVolume!.volumeInfo.imageLinks?.thumbnail,
            ));

        if (volumeCategoryLoading.currentVolumeNumber - 1 >= books.length) {
          books.add(book);
        } else {
          books[volumeCategoryLoading.currentVolumeNumber - 1] = book;
        }
      }

      return BookCategoryLoading(
          books: books,
          currentBookNumber: volumeCategoryLoading.currentVolumeNumber,
          totalBookNumber: volumeCategoryLoading.totalVolumeNumber);
    });
  }

  void deleteBook(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) {
    final isbn = _getIsbnFromIndustryIds(industryIdsByType);

    _bookService.deleteBookByIsbn(isbn);
  }

  String _getIsbnFromIndustryIds(Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType) {
    return (industryIdsByType[IndustryIdentifierType.isbn13]?.identifier ??
            industryIdsByType[IndustryIdentifierType.isbn10]?.identifier) ??
        '';
  }
}
