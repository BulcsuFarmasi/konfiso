import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_category_exception.dart';
import 'package:konfiso/features/book/data/book_category_loading.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/data/volume_category_loading.dart';
import 'package:konfiso/features/book/services/book_service.dart';

final bookCategoryRepositoryProvider = Provider((Ref ref) => BookCategoryRepository(ref.read(bookServiceProvider)));

class BookCategoryRepository {
  BookCategoryRepository(this._bookService);

  final BookService _bookService;

  Stream<BookCategoryLoading> loadBooksByReadingStatus(BookReadingStatus bookReadingStatus) {
    return _bookService.loadBooksByReadingStatus(bookReadingStatus).handleError((_) {
      throw BookCategoryException();
    }).map((VolumeCategoryLoading volumeCategoryLoading) {
      final books = volumeCategoryLoading.volumes
          .map((Volume volume) => Book(
              title: volume.volumeInfo.title,
              industryIds: volume.volumeInfo.industryIdentifiers!
                  .map((VolumeIndustryIdentifier volumeIndustryIdentifier) => BookIndustryIdentifier(
                      IndustryIdentifierType.fromString(volumeIndustryIdentifier.type),
                      volumeIndustryIdentifier.identifier))
                  .toList(),
              authors: volume.volumeInfo.authors,
              coverImageLarge: volume.volumeInfo.imageLinks?.small))
          .toList();

      return BookCategoryLoading(
          books, volumeCategoryLoading.currentVolumeNumber, volumeCategoryLoading.totalVolumeNumber);
    });
  }
}
