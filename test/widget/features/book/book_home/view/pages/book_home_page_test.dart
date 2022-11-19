import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/book_home/view/pages/book_home_page.dart';
import 'package:konfiso/features/book/book_home/view/widgets/book_home_menu_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('BookHomePage', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BookHomePage(),
      );
    }

    testWidgets('should contain the books text',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Books'), findsOneWidget);
    });

    testWidgets('should contain 3 book home menu item',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(BookHomeMenuItem), findsNWidgets(3));
    });

    testWidgets('should contain FAB', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(
          find.descendant(
              of: find.byType(FloatingActionButton),
              matching: find.byIcon(Icons.add)),
          findsOneWidget);
    });
  });
}
