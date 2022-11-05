import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_form.dart';

void main() {
  group('SignInForm', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: Scaffold(
          body: SignInForm(),
        ),
      );
    }

    testWidgets('should find a form', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Form), findsOneWidget);
    });
    testWidgets('should find two text form fields', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextFormField), findsNWidgets(2));
    });
    testWidgets('should find a button', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should the text and the link in it', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text("If you don't have an account, "), findsOneWidget);
      expect(find.descendant(of: find.byType(GestureDetector), matching: find.text('sign up'),), findsOneWidget);
    });
  });
}
