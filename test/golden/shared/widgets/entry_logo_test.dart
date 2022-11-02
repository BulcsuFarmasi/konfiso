import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

void main() {
  group('EntryLogo', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: EntryLogo(),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(EntryLogo), matchesGoldenFile('entry_logo_test.png'));
    });
  });
}
