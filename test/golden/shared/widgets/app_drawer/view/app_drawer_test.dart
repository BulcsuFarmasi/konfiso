import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/widgets/app_drawer/view/app_drawer.dart';

void main() {
  group('AppDrawer', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: AppDrawer(),
      );
    }

    testWidgets('should contain the app\'s name',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Konfiso'), findsOneWidget);
    });

    testWidgets('shold contain menu items', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // Logout
      expect(find.byIcon(Icons.exit_to_app), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
    });
  });
}
