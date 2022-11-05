import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_form.dart';

void main() {
  group('SignUpForm', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: Scaffold(
          body: SignUpForm(),
        ),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(
          find.byType(SignUpForm), matchesGoldenFile('sign_up_form_test.png'));
    });
  });
}
