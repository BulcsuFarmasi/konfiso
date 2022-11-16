import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/book_home/view/widgets/book_home_menu_item.dart';
import 'package:konfiso/features/book/model/book_reading_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('BookHomeMenuItem', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BookHomeMenuItem(readingStatus: BookReadingStatus.alreadyRead));
    }

    testWidgets('should contain the text version of the reading status',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Already Read'), findsOneWidget);
    });
  });
}
