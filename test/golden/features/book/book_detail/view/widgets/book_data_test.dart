import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_data.dart';
import 'package:konfiso/features/book/model/book.dart';

void main() {
  group('BookData', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BookData(book: Book(title: 'a', externalId: 'b')),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(BookData),
          matchesGoldenFile('book_data_test.png'));
    });
  });
}