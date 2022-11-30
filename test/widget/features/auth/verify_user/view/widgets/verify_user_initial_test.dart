import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/verify_user/view/widgets/verify_user_initial.dart';

void main() {
  group('VerifyUserInitial', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: VerifyUserInitial());
    }

    testWidgets('should contain email text', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('We\'ve sent an email to verify your email address'), findsOneWidget);
    });

    testWidgets('should contain click text', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Please click on the link in the email, then return here'), findsOneWidget);
    });

    testWidgets('should contain circular progress indicator', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
