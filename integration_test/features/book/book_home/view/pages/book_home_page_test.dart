import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:konfiso/features/book/%20model/book_reading_status.dart';
import 'package:konfiso/features/book/book_category/view/pages/book_category_page.dart';
import 'package:konfiso/features/book/book_home/view/pages/book_home_page.dart';

void main() {
  group('BookHomePage', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: const BookHomePage(),
        routes: {
          BookCategoryPage.routeName: (BuildContext context) =>
              const BookCategoryPage()
        },
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

      final menuItem = find
          .byKey(const ValueKey<BookReadingStatus>(BookReadingStatus.reading));

      await widgetTester.tap(menuItem);

      await widgetTester.pumpAndSettle();

      expect(find.byType(BookCategoryPage), findsOneWidget);

      expect(find.text(BookReadingStatus.reading.toString()), findsOneWidget);
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
          find.text(BookReadingStatus.wantToRead.toString()), findsOneWidget);
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
          find.text(BookReadingStatus.alreadyRead.toString()), findsOneWidget);
    });
  });
}
