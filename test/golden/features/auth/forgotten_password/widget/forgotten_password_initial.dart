import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_initial.dart';

void main() {
  group('ForgottenPasswordInitial', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ForgottenPasswordInitial(),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ForgottenPasswordInitial),
          matchesGoldenFile('forgotten_password_initial_test.png'));
    });
  });
}