import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/book_home/view/book_home_page.dart';

void main() {
  group('BookHomePage', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(home: BookHomePage(),);
    }
    testWidgets(
        'should contain the books text', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Books'), findsOneWidget);
    });
  });

}