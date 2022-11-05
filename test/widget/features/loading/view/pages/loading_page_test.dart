import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/loading/view/pages/loading_page.dart';

void main() {
  group('LoadingPage', () {
    Widget createWidgetUnderTest() {
      return const ProviderScope(child: MaterialApp(home: LoadingPage()));
    }

    testWidgets('should find a circular progress indicator',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should a text with loading in it',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Loading'), findsOneWidget);
    });
  });
}
