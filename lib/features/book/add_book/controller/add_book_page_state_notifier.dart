import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_state.dart';
import 'package:konfiso/features/book/add_book/model/add_book_resopsitory.dart';

final addBookPageStateNotifierProvider =
StateNotifierProvider<AddBookPageStateNotifier, AddBookPageState>(
        (Ref ref) => AddBookPageStateNotifier(ref.read(addBookRepositoryProvider)));

class AddBookPageStateNotifier extends StateNotifier<AddBookPageState> {
  AddBookPageStateNotifier(this._addBookRepository) : super(const AddBookPageState.initial());

  final AddBookRepository _addBookRepository;

  void search(String searchTerm) async {
    state = const AddBookPageState.inProgress();

    final books = await _addBookRepository.search(searchTerm);
    state = AddBookPageState.successful(books);
  }
}
