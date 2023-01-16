import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_page_state_notifier.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_state.dart';
import 'package:konfiso/features/book/add_book/model/add_book_repository.dart';
import 'package:konfiso/features/book/data/add_book_exception.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:mocktail/mocktail.dart';

class MockAddBookRepository extends Mock implements AddBookRepository {}

void main() {
  late AddBookPageStateNotifier addBookPageStateNotifier;
  late AddBookRepository addBookRepository;
  late List<Book> books;
  late String searchTerm;

  setUp(() {
    addBookRepository = MockAddBookRepository();
    addBookPageStateNotifier = AddBookPageStateNotifier(addBookRepository);
    books = [
      const Book(title: 'a', industryIds: [BookIndustryIdentifier(IndustryIdentifierType.isbn13, '12234567898765')]),
      const Book(title: 'c', industryIds: [BookIndustryIdentifier(IndustryIdentifierType.isbn13, '12234567898765')]),
      const Book(title: 'e', industryIds: [BookIndustryIdentifier(IndustryIdentifierType.isbn13, '12234567898765')]),
    ];
    searchTerm = 'apple';
  });

  void arrangeRepositoryReturnsWithBooks(String searchTerm) {
    when(() => addBookRepository.search(searchTerm)).thenAnswer((_) => Future.value(books));
  }

  void arrangeRepositoryThrowsError(String searchTerm) {
    when(() => addBookRepository.search(searchTerm)).thenThrow(AddBookException());
  }

  group('AddBookPageStateNotifier', () {
    group('search', () {
      test('should repositry\'s search method', () {
        arrangeRepositoryReturnsWithBooks(searchTerm);

        addBookPageStateNotifier.search(searchTerm);

        verify(() => addBookRepository.search(searchTerm));
      });
      test('should emit success state with books if that was given from repository', () async {
        arrangeRepositoryReturnsWithBooks(searchTerm);

        addBookPageStateNotifier.search(searchTerm);

        expect(
          addBookPageStateNotifier.state,
          const AddBookPageState.inProgress(),
        );

        await Future.delayed(const Duration(milliseconds: 500));

        expect(
          addBookPageStateNotifier.state,
          AddBookPageState.successful(books),
        );
      });
      test('should emit error state with books if error was given from repository', () async {
        arrangeRepositoryThrowsError(searchTerm);

        addBookPageStateNotifier.search(searchTerm);

        expect(addBookPageStateNotifier.state, const AddBookPageState.error());
      });
      group('restoreInitial', () {
        test('should reset the state into initial', () {
          addBookPageStateNotifier.state = const AddBookPageState.inProgress();

          addBookPageStateNotifier.restoreToInitial();

          emitsInOrder([
            const AddBookPageState.inProgress(),
            const AddBookPageState.initial(),
          ]);
        });
      });
    });
  });
}
