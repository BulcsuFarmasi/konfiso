import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_reading_detail_form.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/book_reading_detail.dart';
import 'package:konfiso/features/book/data/book_reading_status.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';

void main() {
  group('BookReadingDetailForm', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
            body: BookReadingDetailForm(
          bookReadingDetail: BookReadingDetail(
            book: Book(
              title: '',
              industryIds: [
                BookIndustryIdentifier(IndustryIdentifierType.isbn13, '12234567898765'),
              ],
            ),
            status: BookReadingStatus.wantToRead,
          ),
        )),
      );
    }

    testWidgets('should contain reading text', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Reading'), findsOneWidget);
    });

    testWidgets('should drop down button', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(DropdownButtonFormField<BookReadingStatus>), findsOneWidget);
    });

    testWidgets('should find three drop down menu items', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(DropdownMenuItem<BookReadingStatus>), findsNWidgets(BookReadingStatus.values.length));
    });

    testWidgets('should contain rating bar', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(RatingBar), findsOneWidget);
    });

    testWidgets('should text field for comment', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
