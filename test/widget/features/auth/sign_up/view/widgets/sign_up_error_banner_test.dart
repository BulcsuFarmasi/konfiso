import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_error_banner.dart';

void main() {
  group('SignUpErrorBanner', () {
    Widget createWidgetUnderTest(SignUpError signUpError) {
      return MaterialApp(
        home: SignUpErrorBanner(error: signUpError),
      );
    }

    testWidgets('should contain the approiate text for existing email',
        (WidgetTester widgetTester) async {
      await widgetTester
          .pumpWidget(createWidgetUnderTest(SignUpError.emailExists));

      expect(
          find.text(
              'This email address is already registered. Please try an another.'),
          findsOneWidget);
    });
    testWidgets('should contain the approiate text for not allowed operation',
        (WidgetTester widgetTester) async {
      await widgetTester
          .pumpWidget(createWidgetUnderTest(SignUpError.operationNotAllowed));

      expect(find.text('This operation is not allowed.'), findsOneWidget);
    });
    testWidgets('should contain the approiate text for too many attemps',
        (WidgetTester widgetTester) async {
      await widgetTester
          .pumpWidget(createWidgetUnderTest(SignUpError.tooManyAttempts));

      expect(
          find.text(
              'You were trying too many times, please try again some time later.'),
          findsOneWidget);
    });
    testWidgets('should contain the approiate text for unknown errors',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest(SignUpError.other));

      expect(find.text('Something went wrong. Please try again later.'),
          findsOneWidget);
    });
  });
}
