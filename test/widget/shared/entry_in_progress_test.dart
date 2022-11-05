import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/shared/widgets/entry_in_progress.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

void main() {
  group('EntryInProgress', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: EntryInProgress(),
      );
    }

    testWidgets('should contain entry logo', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(EntryLogo), findsOneWidget);
    });

    testWidgets('should contain a circular progress indicator',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
