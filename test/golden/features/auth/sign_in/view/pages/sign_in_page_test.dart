import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';

void main() {
  group('SignInPage', () {
    Widget createWidgetUnderTest() {
      return const ProviderScope(child: MaterialApp(home: SignInPage(),));
    }
    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignInPage), matchesGoldenFile('sign_in_page_test.png'));
    });
  });
}