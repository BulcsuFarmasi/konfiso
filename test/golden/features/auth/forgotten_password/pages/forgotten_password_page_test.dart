import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../unit/features/auth/forgotten_password/view/page/forgotten_password_page.dart';

void main() {
  group('ForgottenPasswordPage', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ForgottenPasswordPage(),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ForgottenPasswordPage),
          matchesGoldenFile('forgotten_password_page_test.png'));
    });
  });
}
