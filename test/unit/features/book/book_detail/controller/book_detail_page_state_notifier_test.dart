import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state_notifier.dart';
import 'package:konfiso/features/book/book_detail/model/book_detail_repository.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:mocktail/mocktail.dart';

class MockBookDetailRepository extends Mock implements BookDetailRepository {}

void main () {
  late BookDetailPageStateNotifier bookDetailPageStateNotifier;
  late BookDetailRepository bookDetailRepository;
  late Book  book;
  late String externalId;

  setUp(() {
    bookDetailRepository = MockBookDetailRepository();
    bookDetailPageStateNotifier = BookDetailPageStateNotifier(bookDetailRepository);
    externalId = 'a';
    book = Book(title: 'a', externalId: externalId);
  });

  void arrangeRepositoryReturnsWithBook(String externalId) {
    when(() => bookDetailRepository.loadBookByExternalId(externalId)).thenAnswer((invocation) => Future.value(book));
  }

  group('BookDetailPageStateNotifier', () {
    group('loadBookByExternalId', () {
      test(
          'should emit inProgress and success states if a book was given from the repositrx',
          () async {
        // arrange repo returns with book
        arrangeRepositoryReturnsWithBook(externalId);
        // check if state is inProgress
        bookDetailPageStateNotifier.loadBookByExternalId(externalId);
        // wait
        expect(bookDetailPageStateNotifier.state,
            const BookDetailPageState.inProgress());
        // check if state is successful with book
        await Future.delayed(const Duration(milliseconds: 500));

        expect(bookDetailPageStateNotifier.state,
            BookDetailPageState.success(book));
      });
    });
  });
}