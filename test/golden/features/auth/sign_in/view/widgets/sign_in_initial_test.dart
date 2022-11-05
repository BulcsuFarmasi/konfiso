import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_initial.dart';

void main() {
  group('SignInInitial', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: Scaffold(
          body: SignInInitial(),
        ),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignInInitial),
          matchesGoldenFile('sign_in_initial_test.png'));
    });
  });
}
