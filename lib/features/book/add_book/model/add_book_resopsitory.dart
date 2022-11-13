import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/model/book.dart';
import 'package:konfiso/features/book/model/volume.dart';
import 'package:konfiso/features/book/services/book_service.dart';

final addBookRepositoryProvider =
    Provider((Ref ref) => AddBookRepository(ref.read(bookServiceProvider)));

class AddBookRepository {
  final BookService _bookService;

  AddBookRepository(this._bookService);

  Future<List<Book>> search(String searchTerm) async {
    if (searchTerm.trim().isEmpty) {
      return [];
    }

    final volumes = await _bookService.search(searchTerm);

    return volumes
        .map((Volume volume) => Book(
            title: volume.volumeInfo.title,
            externalId: volume.id,
            authors: volume.volumeInfo.authors,
            coverImageSmall: volume.volumeInfo.imageLinks?.thumbnail))
        .toList();
  }
}