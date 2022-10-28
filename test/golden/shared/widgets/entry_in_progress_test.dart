import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/shared/widgets/entry_in_progress.dart';

void main() {

  group('EntryInProgress', () {

    void createWidgetUnderTest() {

    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(home: EntryInProgress(),));

      expect(find.byType(EntryInProgress), matchesGoldenFile('entry_in_progress_test.png'));
    });
  });
}