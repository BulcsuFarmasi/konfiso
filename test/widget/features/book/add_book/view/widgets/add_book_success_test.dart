import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_success.dart';
import 'package:konfiso/features/book/add_book/view/widgets/book_tile.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';

void main() {
  group('AddBookSuccess', () {
    Widget createWidgetUnderTest(List<Book> books) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Column(
            children: [AddBookSuccess(books: books)],
          ),
        ),
      );
    }

    testWidgets('should display as many BookTile as book it got', (WidgetTester widgetTester) async {
      const books = [
        Book(title: 'a', industryIds: [BookIndustryIdentifier(IndustryIdentifierType.isbn13, '12234567898765')]),
        Book(title: 'c', industryIds: [BookIndustryIdentifier(IndustryIdentifierType.isbn13, '12234567898765')]),
        Book(title: 'e', industryIds: [BookIndustryIdentifier(IndustryIdentifierType.isbn13, '12234567898765')]),
      ];
      await widgetTester.pumpWidget(createWidgetUnderTest(books));

      expect(find.byType(BookTile), findsNWidgets(books.length));
    });

    testWidgets('should display text if got no book', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest([]));

      // expect to find text
      expect(find.text('No Books Found'), findsOneWidget);
    });
  });
}
