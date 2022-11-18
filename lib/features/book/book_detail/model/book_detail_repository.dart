import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/model/book.dart';
import 'package:konfiso/features/book/model/industry_identifier.dart';
import 'package:konfiso/features/book/model/volume.dart';
import 'package:konfiso/features/book/services/book_service.dart';

final bookDetailRepositoryProvider =
    Provider((Ref ref) => BookDetailRepository(ref.read(bookServiceProvider)));

class BookDetailRepository {
  BookDetailRepository(this._bookService);

  final BookService _bookService;

  Future<Book> loadBookByExternalId(String externalId) async {
    final volume = await _bookService.loadBookByExternalId(externalId);

    final publicationYear = volume.volumeInfo.publishedDate?.split('-').first;

    return Book(
      title: volume.volumeInfo.title,
      externalId: volume.id,
      authors: volume.volumeInfo.authors,
      publicationYear: publicationYear,
      coverImageLarge: volume.volumeInfo.imageLinks?.small,
      industryIds: volume.volumeInfo.industryIdentifiers
          ?.map((VolumeIndustryIdentifier industryIdentifier) =>
              BookIndustryIdentifier(
                  IndustryIdentifierType.fromString(industryIdentifier.type),
                  industryIdentifier.identifier))
          .toList(),
    );
  }
}
