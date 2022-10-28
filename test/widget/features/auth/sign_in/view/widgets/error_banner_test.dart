import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/error_banner.dart';

void main() {
  group('ErrorBanner', () {
    Widget createWidgetUnderTest(SignInError signInError) {
      return MaterialApp(
        home: ErrorBanner(error: signInError),
      );
    }

    testWidgets('should contain the approiate text for invalid email',
        (WidgetTester widgetTester) async {
      await widgetTester
          .pumpWidget(createWidgetUnderTest(SignInError.invalidEmail));

      expect(find.text('Wrong email or password'), findsOneWidget);
    });
    testWidgets('should contain the approiate text for invalid password',
        (WidgetTester widgetTester) async {
      await widgetTester
          .pumpWidget(createWidgetUnderTest(SignInError.invalidPassword));

      expect(find.text('Wrong email or password'), findsOneWidget);
    });
    testWidgets('should contain the approiate text for disabled users',
        (WidgetTester widgetTester) async {
      await widgetTester
          .pumpWidget(createWidgetUnderTest(SignInError.userDisabled));

      expect(find.text('Your account has been disabled.'), findsOneWidget);
    });
    testWidgets('should contain the approiate text for unknown errors',
        (WidgetTester widgetTester) async {
      await widgetTester
          .pumpWidget(createWidgetUnderTest(SignInError.other));

      expect(find.text('Something went wrong. Please try again later.'),
          findsOneWidget);
    });
  });
}
