import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_successful.dart';

void main() {
  group('SignUpSuccessful', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: SignUpSuccessful(),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignUpSuccessful),
          matchesGoldenFile('sign_up_successful_test.png'));
    });
  });
}