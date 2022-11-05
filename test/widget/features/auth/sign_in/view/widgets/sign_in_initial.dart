import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_form.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_initial.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

void main() {
  group('SignInInitial', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
          child: SignInInitial(),
        )),
      );
    }

    testWidgets('should find entry logo', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(EntryLogo), findsOneWidget);
    });

    testWidgets('should find sign in form', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignInForm), findsOneWidget);
    });
  });
}
