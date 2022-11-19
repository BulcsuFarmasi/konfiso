import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/data/add_book_exception.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:konfiso/features/book/data/volume.dart';
import 'package:konfiso/features/book/services/book_service.dart';
import 'package:konfiso/shared/exceptions/network_execption.dart';

final addBookRepositoryProvider =
    Provider((Ref ref) => AddBookRepository(ref.read(bookServiceProvider)));

class AddBookRepository {
  final BookService _bookService;

  AddBookRepository(this._bookService);

  Future<List<Book>> search(String searchTerm) async {
    if (searchTerm.trim().isEmpty) {
      return [];
    }

    try {
      final volumes = await _bookService.search(searchTerm);

      return volumes
          .map((Volume volume) => Book(
                title: volume.volumeInfo.title,
                externalId: volume.id,
                authors: volume.volumeInfo.authors,
                coverImageSmall: volume.volumeInfo.imageLinks?.thumbnail,
                industryIds: volume.volumeInfo.industryIdentifiers
                    ?.map((VolumeIndustryIdentifier industryIdentifier) =>
                        BookIndustryIdentifier(
                            IndustryIdentifierType.fromString(
                                industryIdentifier.type),
                            industryIdentifier.identifier))
                    .toList(),
              ))
          .toList();
    } on NetworkException {
      throw AddBookException();
    }
  }
}
