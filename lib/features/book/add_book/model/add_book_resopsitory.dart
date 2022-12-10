import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/add_book_exception.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final addBookRepositoryProvider = Provider((Ref ref) => AddBookRepository(ref.read(bookServiceProvider)));

class AddBookRepository {
  final BookService _bookService;

  AddBookRepository(this._bookService);

  Future<List<Book>> search(String searchTerm) async {
    if (searchTerm.trim().isEmpty) {
      return [];
    }

    try {
      List<Volume> volumes = await _bookService.search(searchTerm);

      return volumes
          .where((Volume volume) =>
              volume.volumeInfo.industryIdentifiers
                  ?.where((VolumeIndustryIdentifier volumeIndustryIdentifier) =>
                      volumeIndustryIdentifier.type == 'ISBN_13' || volumeIndustryIdentifier.type == 'ISBN_10')
                  .isNotEmpty ??
              false)
          .map((Volume volume) => Book(
                title: volume.volumeInfo.title,
                authors: volume.volumeInfo.authors,
                coverImage:  CoverImage(smallest: volume.volumeInfo.imageLinks?.smallThumbnail),
                industryIds: volume.volumeInfo.industryIdentifiers!
                    .map((VolumeIndustryIdentifier industryIdentifier) => BookIndustryIdentifier(
                        IndustryIdentifierType.fromString(industryIdentifier.type), industryIdentifier.identifier))
                    .toList(),
              ))
          .toList();
    } on NetworkException {
      throw AddBookException();
    }
  }
}
