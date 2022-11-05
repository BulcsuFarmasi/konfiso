import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_successful.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

void main() {
  group('SignUpSucessful', () {
    Widget createWidgetUndrderTest() {
      return const MaterialApp(
        home: Scaffold(
          body: SignUpSuccessful(),
        ),
      );
    }

    testWidgets('should contain entry logo', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUndrderTest());

      expect(find.byType(EntryLogo), findsOneWidget);
    });

    testWidgets('should find gratulations text',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUndrderTest());

      expect(find.text('Successful registration!'), findsOneWidget);
    });

    testWidgets('should contain link to sign in',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUndrderTest());

      expect(
          find.descendant(
              of: find.byType(GestureDetector),
              matching: find.text('Now you can login here')),
          findsOneWidget);
    });
  });
}
