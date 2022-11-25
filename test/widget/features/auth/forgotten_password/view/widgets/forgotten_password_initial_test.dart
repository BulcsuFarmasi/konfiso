import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_form.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_info_text.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_initial.dart';

void main() {
  group('ForgottenPasswordInitial', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: ForgottenPasswordInitial()),
      );
    }

    testWidgets('should contain info text', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ForgottenPasswordInfoText), findsOneWidget);
    });
    testWidgets('should contain form', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ForgottenPasswordForm), findsOneWidget);
    });
  });
}
