import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_error.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('AddBookError', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: AddBookError());
    }

    testWidgets('should contain error text', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // check for error message
      expect(
          find.text('An error occured, couldn\'t load books'), findsOneWidget);
    });
  });
}
