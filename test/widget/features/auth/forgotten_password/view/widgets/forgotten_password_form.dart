import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_form.dart';

void main() {
  group('ForgottenPasswordForm', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ForgottenPasswordForm(),
        ),
      );
    }

    testWidgets('should contain a text form field', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // checkif contains a text form field
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('should display a button with send email text', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // check button
      expect(find.descendant(of: find.byType(ElevatedButton), matching: find.text('Send Email')), findsOneWidget);
    });
  });
}
