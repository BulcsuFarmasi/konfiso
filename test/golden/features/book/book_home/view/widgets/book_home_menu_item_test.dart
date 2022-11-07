import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/%20model/book_reading_status.dart';
import 'package:konfiso/features/book/book_home/view/widgets/book_home_menu_item.dart';

void main() {
  group('BookHomeMenuItem', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: BookHomeMenuItem(readingStatus: BookReadingStatus.alreadyRead,),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(BookHomeMenuItem),
          matchesGoldenFile('book_home_menu_item_test.png'));
    });
  });
}