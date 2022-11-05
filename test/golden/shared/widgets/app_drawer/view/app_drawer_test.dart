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

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(AppDrawer),
          matchesGoldenFile('app_drawer_test.png'));
    });
  });
}