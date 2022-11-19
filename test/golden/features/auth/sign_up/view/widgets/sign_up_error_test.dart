import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart'
    as sign_up_error;
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_error.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('SignUpError', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: SignUpError(error: sign_up_error.SignUpError.other),
          ),
        ),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignUpError),
          matchesGoldenFile('sign_up_error_test.png'));
    });
  });
}
