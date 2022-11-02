import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/loading/view/pages/loading_page.dart';

void main() {
  group('LoadingPage', skip: 'TODO missing plugin', () {
    Widget createWidgetUnderTest() {
      return const ProviderScope(
        child: MaterialApp(
          home: LoadingPage(),
        ),
      );
    }

    testWidgets('should match golden image', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(
          find.byType(LoadingPage), matchesGoldenFile('loading_page_test.png'));
    });
  });
}
