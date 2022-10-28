import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart' as sign_in_error;
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_error.dart';

void main() {
  group('SignInError', skip: 'TODO found was causes the layout problem', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: Scaffold(body: SignInError(error: sign_in_error.SignInError.other)),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(
          find.byType(SignInError), matchesGoldenFile('sign_in_error_test.png'));
    });
  });
}