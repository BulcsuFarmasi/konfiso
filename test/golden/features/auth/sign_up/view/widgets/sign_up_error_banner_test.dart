import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_error_banner.dart';

void main() {
  group('SignUpErrorBanner', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SignUpErrorBanner(error: SignUpError.other),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignUpErrorBanner), matchesGoldenFile('sign_up_error_banner_test.png'));
    });
  });
}
