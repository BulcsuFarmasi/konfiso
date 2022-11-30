import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_loading_success.dart';
import 'package:konfiso/features/book/data/book.dart';
import 'package:konfiso/features/book/data/industry_identifier.dart';

void main() {
  group('BookDetailSuccess', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BookDetailLoadingSuccess(
            book: Book(
              title: '',
              industryIds: [
                BookIndustryIdentifier(IndustryIdentifierType.isbn13, '12234567898765'),
              ],
            ),
          ),
        ),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(BookDetailLoadingSuccess), matchesGoldenFile('book_detail_page_test.png'));
    });
  });
}
