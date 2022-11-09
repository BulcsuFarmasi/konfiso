import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/model/volume.dart';
import 'package:konfiso/features/book/services/book_remote.dart';

final bookServiceProvider = Provider((ref) => BookService(ref.read(bookRemoteProvider)));

class BookService {
  final BookRemote _bookRemote;

  BookService(this._bookRemote);

  Future<List<Volume>> search(String searchTerm) async {
    return _bookRemote.search(searchTerm);
  }
}