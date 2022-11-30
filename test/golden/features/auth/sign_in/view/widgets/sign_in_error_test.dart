import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart'
as sign_in_error;
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_error.dart';

void main() {
  group('SignInError', () {
    Widget createWidgetUnderTest() {
      return const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: SignInError(error: sign_in_error.SignInError.other),
            ),
          ),
        ),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Scaffold), matchesGoldenFile('sign_in_error_test.png'));
    });
  });
}
