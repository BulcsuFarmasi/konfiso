import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_up/view/pages/sign_up_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('SignUpPage', () {
    Widget createWidgetUnderTest() {
      return const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SignUpPage(),
        ),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(
          find.byType(SignUpPage), matchesGoldenFile('sign_up_page_test.png'));
    });
  });
}
