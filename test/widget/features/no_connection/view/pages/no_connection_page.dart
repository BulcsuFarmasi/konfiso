import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/no_connection/view/pages/no_connection_page.dart';

void main() {
  group('NoConnectionPage', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: NoConnectionPage(),
      );
    }

    testWidgets('should display a no connection icon', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.signal_wifi_connected_no_internet_4), findsOneWidget);
    });
    testWidgets('should display a no connection text', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('No internet connection'), findsOneWidget);
    });
    testWidgets('should display an explanation text', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('To use the app, please connect your device to the internet'), findsOneWidget);
    });
  });
}
