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
    final List<Book> books = [];
    return _bookService.loadBooksByReadingStatus(bookReadingStatus).handleError((_) {
      throw BookCategoryException();
    }).map((VolumeCategoryLoading volumeCategoryLoading) {
      final actualVolume = volumeCategoryLoading.volumes.last;

      final industryIdsByType = {
        for (VolumeIndustryIdentifier volumeIndustryIdentifier in actualVolume.volumeInfo.industryIdentifiers!)
          IndustryIdentifierType.fromString(volumeIndustryIdentifier.type): BookIndustryIdentifier(
              IndustryIdentifierType.fromString(volumeIndustryIdentifier.type), volumeIndustryIdentifier.identifier)
      };

      final book = Book(
          title: actualVolume.volumeInfo.title,
          industryIdsByType: industryIdsByType,
          authors: actualVolume.volumeInfo.authors,
          coverImage: CoverImage(
            smaller: actualVolume.volumeInfo.imageLinks?.thumbnail,
          ));

      books.add(book);

      return BookCategoryLoading(
          books, volumeCategoryLoading.currentVolumeNumber, volumeCategoryLoading.totalVolumeNumber);
    });
  }
}
