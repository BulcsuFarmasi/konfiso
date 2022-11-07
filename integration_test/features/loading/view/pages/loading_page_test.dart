import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/book/book_home/view/pages/book_home_page.dart';
import 'package:konfiso/features/loading/controller/loading_page_controller.dart';
import 'package:konfiso/features/loading/view/pages/loading_page.dart';
import 'package:mocktail/mocktail.dart';

class MockLoadingPageController extends Mock
    implements LoadingPageController {}

void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('LoadingPage', () {
    late LoadingPageController loadingPageController;

    Widget createWidgetUinderTest() {
      return ProviderScope(
          overrides: [
            loadingPageControllerProvider.overrideWith((_) => loadingPageController),
          ],
          child: MaterialApp(home: const LoadingPage(), routes: {
            SignInPage.routeName: (BuildContext context) => const SignInPage(),
            BookHomePage.routeName: (BuildContext context) =>
                const BookHomePage(),
          }));
    }

    setUp(() {
      loadingPageController = MockLoadingPageController();
    });

    testWidgets('should navigate to login page when auto login returns false',
        (WidgetTester widgetTester) async {
      when(() => loadingPageController.autoSignIn())
          .thenAnswer((_) => Future.value(false));
      await widgetTester.pumpWidget(createWidgetUinderTest());
      expect(find.byType(LoadingPage), findsOneWidget);
      await widgetTester.pumpAndSettle();
      expect(find.byType(SignInPage), findsOneWidget);
    });

    testWidgets(
        'should navigate to books home page when auto login returns true',
        (WidgetTester widgetTester) async {
      when(() => loadingPageController.autoSignIn())
          .thenAnswer((_) => Future.value(true));
      await widgetTester.pumpWidget(createWidgetUinderTest());
      expect(find.byType(LoadingPage), findsOneWidget);
      await widgetTester.pumpAndSettle();
      expect(find.byType(BookHomePage), findsOneWidget);
    });
  });
}
