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
    final volumes = await _bookService.search(searchTerm);

    return [
      const Book(
          title: 'Harry Potter és az azkabani fogoly',
          externalId: 'iLPwzgEACAAJ',
          authors: ['J. K. Rowling']),
      const Book(
        title: 'Harry Potter és a Félvér Herceg',
        externalId: 'KF99DAAAQBAJ',
        authors: ['J. K. Rowling'],
      ),
      const Book(
          title: 'Harry Potter és a Titkok Kamrája',
          externalId: 'tl19DAAAQBAJ',
          authors: ['J. K. Rowling']),
      const Book(
          title: 'Harry Potter és a Bölcsek köve',
          externalId: 'iLPwzgEACAAJ',
          authors: ['J. K. Rowling']),
      const Book(
          title: 'Harry Potter és a Főnix Rendje',
          externalId: '3F19DAAAQBAJ',
          authors: ['J. K. Rowling'],
          coverImageSmall:
              'http://books.google.com/books/publisher/content?id=3F19DAAAQBAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE71T2nbwXuo9gaUgxNVMvKds1I7ef68H8y9JoiksP7hhFc0uvIcANlxZvesVhywGLf2E7rhe_RTWUhm3av5X0pbALOpYLGsZG34iQU1hqAbcl0mHXLXJ7r21G8anPaCmIhzS6z1Q&source=gbs_api'),
    ];

    // return volumes.map((Volume volume) =>
    //     Book(title: volume.volumeInfo.title,
    //         externalId: volume.id,
    //         authors: volume.volumeInfo.authors,
    //         coverImageSmall: volume.volumeInfo.imageLinks.thumbnail)).toList();
  }
}
