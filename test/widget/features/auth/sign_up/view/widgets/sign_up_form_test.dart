import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('SignUpForm', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SignUpForm(),
        ),
      );
    }

    testWidgets('should find a form', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Form), findsOneWidget);
    });
    testWidgets('should find three text form fields', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextFormField), findsNWidgets(3));
    });
    testWidgets('should find a button', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should the text and the link up it', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('If you have an account, '), findsOneWidget);
      expect(
          find.descendant(
            of: find.byType(GestureDetector),
            matching: find.text('log in'),
          ),
          findsOneWidget);
    });
  });
}
