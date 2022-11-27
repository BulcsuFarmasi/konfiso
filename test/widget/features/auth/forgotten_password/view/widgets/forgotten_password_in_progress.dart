import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_in_progress.dart';

void main() {
  group('ForgottenPasswordInProgress', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ForgottenPasswordInProgress());
    }

    testWidgets('should display circular progress indicator', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
