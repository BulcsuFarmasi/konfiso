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
          home: ForgottenPasswordInfoText());
    }

    testWidgets('should display info text', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // check text
      expect(
          find.text(
              'Please provide your e-mail address below, so we can send the email with which you can set a new password'),
          findsOneWidget);
    });
  });
}
