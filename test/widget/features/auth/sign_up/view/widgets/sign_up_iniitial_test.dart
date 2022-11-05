import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_form.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_initial.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

void main() {
  group('SignUpINitial', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
              child: SignUpInitial(),
            )),
      );
    }

    testWidgets('should find entry logo', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(EntryLogo), findsOneWidget);
    });

    testWidgets('should find sign up form', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignUpForm), findsOneWidget);
    });
  });
}