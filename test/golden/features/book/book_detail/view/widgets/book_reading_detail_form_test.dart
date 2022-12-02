import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          ),
        ),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(BookReadingDetailForm), matchesGoldenFile('book_reading_detail_form_test.png'));
    });
  });
}
