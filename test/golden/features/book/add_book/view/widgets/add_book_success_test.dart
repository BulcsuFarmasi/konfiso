import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_success.dart';

void main() {
  group('AddBookSuccess', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: Column(children: const [AddBookSuccess(books: [])])),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(AddBookSuccess), matchesGoldenFile('add_book_success_test.png'));
    });
  });
}
