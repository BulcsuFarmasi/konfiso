import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_page_state_notifier.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_state.dart';
import 'package:konfiso/features/book/add_book/view/pages/add_book_page.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_in_progress.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_search.dart';
import 'package:konfiso/features/book/add_book/view/widgets/book_tile.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state_notifier.dart';
import 'package:konfiso/features/book/book_detail/view/pages/book_detail_page.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';
import 'package:mocktail/mocktail.dart';

class MockAddBookStateNotifier extends StateNotifier<AddBookPageState> with Mock implements AddBookPageStateNotifier {
  MockAddBookStateNotifier(super.state);
}

class MockBookDetailStateNotifier extends StateNotifier<BookDetailPageState>
    with Mock
    implements BookDetailPageStateNotifier {
  MockBookDetailStateNotifier(super.state);
}

void main() {
  group('AddBookPage', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    late List<Book> books;
    late AddBookPageStateNotifier addBookPageStateNotifier;
    late BookDetailPageStateNotifier bookDetailPageStateNotifier;

    setUp(() {
      addBookPageStateNotifier = MockAddBookStateNotifier(const AddBookPageState.initial());
      bookDetailPageStateNotifier = MockBookDetailStateNotifier(const BookDetailPageState.initial());
      books = [
        const Book(title: 'a', industryIds: [BookIndustryIdentifier(IndustryIdentifierType.isbn13, '1234567898765')]),
        const Book(title: 'd', industryIds: [BookIndustryIdentifier(IndustryIdentifierType.isbn13, '9876543212345')]),
      ];
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          addBookPageStateNotifierProvider.overrideWith((_) => addBookPageStateNotifier),
          bookDetailPageStateNotifierProvider.overrideWith((_) => bookDetailPageStateNotifier),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AddBookPage(),
          routes: {
            BookDetailPage.routeName: (BuildContext context) => const BookDetailPage(),
          },
        ),
      );
    }

    Future<void> loadWidgetAndEnterText(WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      final searchField = find.byType(TextField);
      await widgetTester.enterText(searchField, 'a');
      await widgetTester.pumpAndSettle();
      addBookPageStateNotifier.state = const AddBookPageState.inProgress();
      await widgetTester.pump();
    }

    Future<void> loadWidgetAndSetStateToSuccessWithBooks(WidgetTester widgetTester) async {
      await loadWidgetAndEnterText(widgetTester);
      addBookPageStateNotifier.state = AddBookPageState.successful(books);
      await widgetTester.pump();
    }

    testWidgets('should AddBookPage be there', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(AddBookPage), findsOneWidget);
    });

    testWidgets('should find AddBookSearch', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(AddBookSearch), findsOneWidget);
    });

    testWidgets('should display the book after search', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(AddBookSearch), findsOneWidget);
    });

    testWidgets('should display loading screen after typing', (WidgetTester widgetTester) async {
      await loadWidgetAndEnterText(widgetTester);

      expect(find.byType(AddBookInProgress), findsOneWidget);
    });

    testWidgets('should display book tile after typing and loading', (WidgetTester widgetTester) async {
      await loadWidgetAndSetStateToSuccessWithBooks(widgetTester);
      expect(find.byType(BookTile), findsNWidgets(books.length));
    });

    testWidgets('should display no books found if no books given', (WidgetTester widgetTester) async {
      await loadWidgetAndEnterText(widgetTester);
      addBookPageStateNotifier.state = const AddBookPageState.successful([]);
      await widgetTester.pump();

      expect(find.text('No Books Found'), findsOneWidget);
    });

    testWidgets('should redirect to book detail after pressing add button', (WidgetTester widgetTester) async {
      await loadWidgetAndSetStateToSuccessWithBooks(widgetTester);
      final button = find.byType(ElevatedButton).first;
      await widgetTester.tap(button);
      await widgetTester.pumpAndSettle();

      expect(find.byType(BookDetailPage), findsOneWidget);
    });

    testWidgets('should display AddBookError if it got an error from stateNotifier', (WidgetTester widgetTester) async {
      await loadWidgetAndEnterText(widgetTester);
      addBookPageStateNotifier.state = const AddBookPageState.error();
      await widgetTester.pump();

      expect(find.text('An error occured, couldn\'t load books'), findsOneWidget);
    });
  });
}
