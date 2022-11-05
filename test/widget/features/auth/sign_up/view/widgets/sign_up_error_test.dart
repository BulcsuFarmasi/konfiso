import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart'
as sign_up_error;
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_error.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_error_banner.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_form.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

void main() {
  group('SignUpError', () {
    Widget createWidgetUnderTest() {
      return  const MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
              child: SignUpError(
                error: sign_up_error.SignUpError.other,
              ),
            )),
      );
    }

    testWidgets('should find entry logo', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(EntryLogo), findsOneWidget);
    });
    testWidgets('should find sign up error banner',
            (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(createWidgetUnderTest());

          expect(find.byType(SignUpErrorBanner), findsOneWidget);
        });

    testWidgets('should find sign up form', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignUpForm), findsOneWidget);
    });
  });
}