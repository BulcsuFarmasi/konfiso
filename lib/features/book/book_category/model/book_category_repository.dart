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
              industryIdsByType: Map.fromIterable(
                  volume.volumeInfo.industryIdentifiers!.map((VolumeIndustryIdentifier industryIdentifier) {
                final industryIdentifierType = IndustryIdentifierType.fromString(industryIdentifier.type);
                return MapEntry(industryIdentifierType,
                    BookIndustryIdentifier(industryIdentifierType, industryIdentifier.identifier));
              })),
              authors: volume.volumeInfo.authors,
              coverImage: CoverImage(smaller: volume.volumeInfo.imageLinks?.thumbnail)))
          .toList();

      return BookCategoryLoading(
          books, volumeCategoryLoading.currentVolumeNumber, volumeCategoryLoading.totalVolumeNumber);
    });
  }
}
