import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_in_progress.dart';

void main() {
  group('BookDetailInProgress', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BookDetailInProgress());
    }

    testWidgets('should display loading indicator',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      // check for loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
