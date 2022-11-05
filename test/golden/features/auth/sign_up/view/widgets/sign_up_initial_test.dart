import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_initial.dart';

void main() {
  group('SignUpInitial', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SignUpInitial(),
          ),
        ),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignUpInitial),
          matchesGoldenFile('sign_up_initial_test.png'));
    });
  });
}
