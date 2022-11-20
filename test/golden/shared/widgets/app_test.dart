import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/widgets/app/view/app.dart';

void main() {
  group('App', () {
    Widget createWidgetUnderTest() {
      return const App();
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(App),
          matchesGoldenFile('app_test.png'));
    });
  });
}