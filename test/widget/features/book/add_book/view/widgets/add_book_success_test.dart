import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_success.dart';
import 'package:konfiso/features/book/add_book/view/widgets/book_tile.dart';
import 'package:konfiso/features/book/model/book.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    testWidgets('should display as many BookTile as book it got',
        (WidgetTester widgetTester) async {
      const books = [
        Book(title: 'a', externalId: 'b'),
        Book(title: 'c', externalId: 'd'),
        Book(title: 'e', externalId: 'f'),
      ];
      await widgetTester.pumpWidget(createWidgetUnderTest(books));


      expect(find.byType(BookTile), findsNWidgets(books.length));
    });

    testWidgets('should display text if got no book',
            (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(createWidgetUnderTest([]));

          // expect to find text
          expect(find.text('No Books Found'), findsOneWidget);
        });
  });
}
