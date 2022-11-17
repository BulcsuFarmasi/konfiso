import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_in_progress.dart';

void main() {
  group('AddBookInProgress', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(home: AddBookInProgress());
    }
    testWidgets('should display a loading indicator', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // check loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

}