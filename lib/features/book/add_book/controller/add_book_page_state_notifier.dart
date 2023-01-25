import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_state.dart';
import 'package:konfiso/features/book/add_book/model/add_book_repository.dart';
import 'package:konfiso/features/book/data/add_book_exception.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';

final addBookPageStateNotifierProvider = StateNotifierProvider<AddBookPageStateNotifier, AddBookPageState>(
    (Ref ref) => AddBookPageStateNotifier(ref.read(addBookRepositoryProvider)));

class AddBookPageStateNotifier extends StateNotifier<AddBookPageState> {
  AddBookPageStateNotifier(this._addBookRepository) : super(const AddBookPageState.initial());

  final AddBookRepository _addBookRepository;

  void search(String searchTerm) async {
    state = const AddBookPageState.inProgress();

    try {
      final books = await _addBookRepository.search(searchTerm);
      state = AddBookPageState.successful(books, searchTerm);
    } on AddBookException catch (_) {
      state = const AddBookPageState.error();
    }
  }

  void restoreToInitial() {
    state = const AddBookPageState.initial();
  }

  Future<void> selectBook(
      Map<IndustryIdentifierType, BookIndustryIdentifier> industryIdsByType, String searchTerm) async {
    await _addBookRepository.selectBook(industryIdsByType, searchTerm);
  }
}
