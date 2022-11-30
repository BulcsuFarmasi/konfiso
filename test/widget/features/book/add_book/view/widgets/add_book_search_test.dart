import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_search.dart';

void main() {
  group('AddBookSearch', () {
    Widget createWidgetUnderTest() {
      return ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: AddBookSearch(startedTyping: () {}),
          ),
        ),
      );
    }

    testWidgets('should contain a text field', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // assert if contains a text field
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
