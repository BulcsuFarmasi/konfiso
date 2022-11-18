import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/add_book/view/widgets/book_tile.dart';
import 'package:konfiso/features/book/model/book.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('BookTile', () {
    Widget createWidgetUnderTest(Book book) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: BookTile(book: book)),
      );
    }

    setUpAll(() {
      HttpOverrides.global = null;
    });

    group('cover', () {
      testWidgets('should display image if cover is given', (widgetTester) async {
        // create book
        const book = Book(
            title: 'Harry Potter and the Charmber of Secrets',
            externalId: 'a',
            coverImageSmall:
                'https://upload.wikimedia.org/wikipedia/en/5/5c/Harry_Potter_and_the_Chamber_of_Secrets.jpg');
        await widgetTester.pumpWidget(createWidgetUnderTest(book));

        final image = find.byType(Image).evaluate().single.widget as Image;
        final source = (image.image as NetworkImage).url;

        expect(source, book.coverImageSmall);
      });
      testWidgets('should display not fallback if cover is not given',
          (WidgetTester widgetTester) async {
        const book = Book(title: 'a', externalId: 'b');
        await widgetTester.pumpWidget(createWidgetUnderTest(book));

        final image = find.byType(Image).evaluate().single.widget as Image;
        final assetName = (image.image as AssetImage).assetName;

        expect(assetName, 'assets/images/no_book_cover.gif');
      });
    });
    group('title', () {
      testWidgets('should display title', (WidgetTester widgetTester) async {
        const book = Book(
            title: 'Harry Potter and the Charmber of Secrets', externalId: 'a');
        await widgetTester.pumpWidget(createWidgetUnderTest(book));

        expect(find.text(book.title), findsOneWidget);
      });
    });
    group('authors', () {
      testWidgets('should display multiple authors',
          (WidgetTester widgetTester) async {
        const book = Book(
            title: 'Harry Potter and the Charmber of Secrets',
            externalId: 'a',
            authors: ['JK Rowling', 'John RR Tolkien']);
        await widgetTester.pumpWidget(createWidgetUnderTest(book));
        expect(find.text(book.authors!.join(', ')), findsOneWidget);
      });
      testWidgets('should display single author',
          (WidgetTester widgetTester) async {
        const book = Book(
            title: 'Harry Potter and the Charmber of Secrets',
            externalId: 'a',
            authors: ['JK Rowling']);
        await widgetTester.pumpWidget(createWidgetUnderTest(book));
        expect(find.text(book.authors!.first), findsOneWidget);
      });

      testWidgets('should not throw error if no authors given',
          (WidgetTester widgetTester) async {
        const book = Book(
            title: 'Harry Potter and the Charmber of Secrets',
            externalId: 'a');
        await widgetTester.pumpWidget(createWidgetUnderTest(book));

        final exception = await widgetTester.takeException();

        expect(exception, isNull);
      });
    });
    group('button', () {
      testWidgets('should display button with text',
          (WidgetTester widgetTester) async {
        // create environment
        await widgetTester.pumpWidget(
            (createWidgetUnderTest(const Book(title: 'a', externalId: 'a'))));

        // check if button exists with text
        expect(
            find.descendant(
                of: find.byType(ElevatedButton), matching: find.text('Add')),
            findsOneWidget);
      });
    });
  });
}
