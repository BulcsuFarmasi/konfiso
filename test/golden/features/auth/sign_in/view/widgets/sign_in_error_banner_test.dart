import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_error_banner.dart';

void main() {
  group('SignInErrorBanner', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SignInErrorBanner(error: SignInError.other),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignInErrorBanner), matchesGoldenFile('sign_in_error_banner_test.png'));
    });
  });
}
