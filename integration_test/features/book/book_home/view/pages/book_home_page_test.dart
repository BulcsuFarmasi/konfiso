import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:konfiso/features/book/model/book_reading_status.dart';
import 'package:konfiso/features/book/add_book/view/pages/add_book_page.dart';
import 'package:konfiso/features/book/book_category/view/pages/book_category_page.dart';
import 'package:konfiso/features/book/book_home/view/pages/book_home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('BookHomePage', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    Widget createWidgetUnderTest() {
      return ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const BookHomePage(),
          routes: {
            BookCategoryPage.routeName: (BuildContext context) =>
                const BookCategoryPage(),
            AddBookPage.routeName: (BuildContext context) =>
                const AddBookPage(),
          },
        ),
      );
    }

    testWidgets('should be initially at book home page',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(BookHomePage), findsOneWidget);
    });

    testWidgets(
        'should go to category page and give the reading reading status as parameter to it',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      final menuItem = find.byKey(const ValueKey<BookReadingStatus>(
          BookReadingStatus.currentlyReading));

      await widgetTester.tap(menuItem);

      await widgetTester.pumpAndSettle();

      expect(find.byType(BookCategoryPage), findsOneWidget);

      expect(find.text('Currently Reading'),
          findsOneWidget);
    });

    testWidgets(
        'should go to category page and give the want to read reading status as parameter to it',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      final menuItem = find.byKey(
          const ValueKey<BookReadingStatus>(BookReadingStatus.wantToRead));

      await widgetTester.tap(menuItem);

      await widgetTester.pumpAndSettle();

      expect(find.byType(BookCategoryPage), findsOneWidget);

      expect(
          find.text('Want to Read'), findsOneWidget);
    });

    testWidgets(
        'should go to category page and give the already read reading status as parameter to it',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      final menuItem = find.byKey(
          const ValueKey<BookReadingStatus>(BookReadingStatus.alreadyRead));

      await widgetTester.tap(menuItem);

      await widgetTester.pumpAndSettle();

      expect(find.byType(BookCategoryPage), findsOneWidget);

      expect(
          find.text('Already Read'), findsOneWidget);
    });

    testWidgets('should go to add book page if fab is pressed',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      final fab = find.byType(FloatingActionButton);

      await widgetTester.tap(fab);

      await widgetTester.pumpAndSettle();

      expect(find.byType(AddBookPage), findsOneWidget);
    });
  });
}
