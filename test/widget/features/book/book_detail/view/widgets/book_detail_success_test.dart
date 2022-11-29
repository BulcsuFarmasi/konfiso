import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_data.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_success.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_reading_detail_form.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';

void main() {
  group('BookDetailSuccess', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: BookDetailSuccess(
              book: Book(
                title: 'a',
                industryIds: [
                  BookIndustryIdentifier(IndustryIdentifierType.isbn13, '12234567898765'),
                ],
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('should display book data', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(BookData), findsOneWidget);
    });

    testWidgets('should display book reading detail form', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(BookReadingDetailForm), findsOneWidget);
    });
  });
}
