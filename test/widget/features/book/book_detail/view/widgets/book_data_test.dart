import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_data.dart';
import 'package:konfiso/features/book/model/book.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/book/model/industry_identifier.dart';

void main() {
  group('BookData', () {
    Widget createWidgetUnderTest(Book book) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
            body: BookData(
          book: book,
        )),
      );
    }

    setUpAll(() {
      HttpOverrides.global = null;
    });
    group('cover', () {
      testWidgets('should display image if cover is given',
          (widgetTester) async {
        // create book
        const book = Book(
            title: 'Harry Potter and the Charmber of Secrets',
            externalId: 'a',
            coverImageLarge:
                'https://upload.wikimedia.org/wikipedia/en/5/5c/Harry_Potter_and_the_Chamber_of_Secrets.jpg');
        await widgetTester.pumpWidget(createWidgetUnderTest(book));

        final image = find.byType(Image).evaluate().single.widget as Image;
        final source = (image.image as NetworkImage).url;

        expect(source, book.coverImageLarge);
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
            title: 'Harry Potter and the Charmber of Secrets', externalId: 'a');
        await widgetTester.pumpWidget(createWidgetUnderTest(book));

        final exception = await widgetTester.takeException();

        expect(exception, isNull);
      });
    });

    group('publicationYear', () {
      testWidgets('should display publicationYear',
          (WidgetTester widgetTester) async {
        const book = Book(
            title: 'Harry Potter and the Charmber of Secrets',
            externalId: 'a',
            publicationYear: '1999');
        await widgetTester.pumpWidget(createWidgetUnderTest(book));

        expect(find.text('Publication Year: '), findsOneWidget);


        expect(find.text(book.publicationYear!), findsOneWidget);
      });
      testWidgets('should not throw expection if no publication year',
          (WidgetTester widgetTester) async {
        const book = Book(
            title: 'Harry Potter and the Charmber of Secrets',
            externalId: 'a');
        await widgetTester.pumpWidget(createWidgetUnderTest(book));

        expect(find.text('Publication Year: '), findsNothing);

        final exception = await widgetTester.takeException();

        expect(exception, isNull);
      });
    });

    group('industryIds', () {
      testWidgets('should display multiple industry ids',
          (WidgetTester widgetTester) async {
        const book = Book(
            title: 'Harry Potter and the Charmber of Secrets',
            externalId: 'a',
            industryIds: [
              BookIndustryIdentifier(
                  IndustryIdentifierType.isbn13, '9876543212345'),
              BookIndustryIdentifier(
                  IndustryIdentifierType.isbn13, '6543212345')
            ]);
        await widgetTester.pumpWidget(createWidgetUnderTest(book));

        expect(find.text('ISBN: '), findsOneWidget);

        final industryIdsText = book.industryIds!
            .map((BookIndustryIdentifier industryIdentifier) =>
                industryIdentifier.identifier)
            .join(', ');
        expect(find.text(industryIdsText), findsOneWidget);
      });
      testWidgets('should display single industry id',
          (WidgetTester widgetTester) async {
        const book = Book(
            title: 'Harry Potter and the Charmber of Secrets',
            externalId: 'a',
            industryIds: [
              BookIndustryIdentifier(
                  IndustryIdentifierType.isbn13, '9876543212345'),
            ]);
        await widgetTester.pumpWidget(createWidgetUnderTest(book));

        expect(find.text('ISBN: '), findsOneWidget);

        expect(find.text(book.industryIds!.first.identifier), findsOneWidget);
      });
      testWidgets('should not throw expection if no industry identfier given',
          (WidgetTester widgetTester) async {
        const book = Book(
          title: 'Harry Potter and the Charmber of Secrets',
          externalId: 'a',
        );
        await widgetTester.pumpWidget(createWidgetUnderTest(book));

        final exception = await widgetTester.takeException();

        expect(exception, isNull);

        expect(find.text('ISBN: '), findsNothing);
      });
    });
  });
}
