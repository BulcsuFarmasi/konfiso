import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/error_banner.dart';

void main() {
  group('ErrorBanner', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: ErrorBanner(error: SignInError.other),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(
          find.byType(ErrorBanner), matchesGoldenFile('error_banner_test.png'));
    });
  });
}
