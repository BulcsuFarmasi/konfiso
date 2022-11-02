import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/widgets/entry_in_progress.dart';

void main() {
  group('EntryLogo', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: EntryInProgress(),
      );
    }

    testWidgets('should a text with a K in it',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('K'), findsOneWidget);
    });
  });
}
