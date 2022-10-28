import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/widgets/entry_in_progress.dart';

void main() {

  group('EntryInProgress', () {

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(home: EntryInProgress(),));

      expect(find.byType(EntryInProgress), matchesGoldenFile('entry_in_progress_test.png'));
    });
  });
}