import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_info_text.dart';

void main() {
  group('ForgottenPasswordInfoText', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ForgottenPasswordInfoText(),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ForgottenPasswordInfoText),
          matchesGoldenFile('forgotten_password_info_text_test.png'));
    });
  });
}