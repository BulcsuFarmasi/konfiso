import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(home: ());
    }
    testWidgets('', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());
    });
  });
  
}