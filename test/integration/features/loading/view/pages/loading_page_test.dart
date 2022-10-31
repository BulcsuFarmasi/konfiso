import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/book/book_home/view/book_home_page.dart';
import 'package:konfiso/features/loading/controller/loading_page_state_notifier.dart';
import 'package:konfiso/features/loading/view/pages/loading_page.dart';
import 'package:mocktail/mocktail.dart';

class MockLoadingPageStateNotifier extends Mock
    implements LoadingPageStateNotifier {}

void main() {
  group('LoadingPage', () {
    late LoadingPageStateNotifier loadingPageStateNotifier;

    Widget createWidgetUinderTest() {
      print(loadingPageStateNotifier);
      return ProviderScope(
          overrides: [
            loadingPageStateNotifierProvider.overrideWithProvider(
                StateNotifierProvider((_) => loadingPageStateNotifier))
          ],
          child: MaterialApp(home: const LoadingPage(), routes: {
            SignInPage.routeName: (BuildContext context) => const SignInPage(),
            BookHomePage.routeName: (BuildContext context) => const BookHomePage(),
          }));
    }

    setUp(() {
      loadingPageStateNotifier = MockLoadingPageStateNotifier();
    });

    testWidgets('should navigate to login page when auto login returns false',
        (WidgetTester widgetTester) async {
      when(() => loadingPageStateNotifier.autoSignIn())
          .thenAnswer((_) => Future.value(false));
      await widgetTester.pumpWidget(createWidgetUinderTest());
      expect(find.byType(LoadingPage), findsOneWidget);
      await widgetTester.pumpAndSettle();
      expect(find.byType(SignInPage), findsOneWidget);
    });

    testWidgets('should navigate to books home page when auto login returns true',
            (WidgetTester widgetTester) async {
          when(() => loadingPageStateNotifier.autoSignIn())
              .thenAnswer((_) => Future.value(true));
          await widgetTester.pumpWidget(createWidgetUinderTest());
          expect(find.byType(LoadingPage), findsOneWidget);
          await widgetTester.pumpAndSettle();
          expect(find.byType(BookHomePage), findsOneWidget);
        });
  });
}
