import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:konfiso/features/auth/data/user_signin_status.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/auth/verify_user/view/pages/verify_user_page.dart';
import 'package:konfiso/features/book/book_home/view/pages/book_home_page.dart';
import 'package:konfiso/features/loading/controller/loading_page_controller.dart';
import 'package:konfiso/features/loading/view/pages/loading_page.dart';
import 'package:mocktail/mocktail.dart';

class MockLoadingPageController extends Mock implements LoadingPageController {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('LoadingPage', () {
    late LoadingPageController loadingPageController;

    Widget createWidgetUnderTest() {
      return ProviderScope(
          overrides: [
            loadingPageControllerProvider.overrideWith((_) => loadingPageController),
          ],
          child: MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const LoadingPage(),
              routes: {
                SignInPage.routeName: (BuildContext context) => const SignInPage(),
                BookHomePage.routeName: (BuildContext context) => const BookHomePage(),
                VerifyUserPage.routeName: (BuildContext context) => const VerifyUserPage(),
              }));
    }

    setUp(() {
      loadingPageController = MockLoadingPageController();
    });

    testWidgets('should navigate to login page when auto login returns not signed in',
        (WidgetTester widgetTester) async {
      when(() => loadingPageController.autoSignIn()).thenAnswer((_) => Future.value(UserSignInStatus.notSignedIn));
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LoadingPage), findsOneWidget);
      await widgetTester.pumpAndSettle();

      expect(find.byType(SignInPage), findsOneWidget);
    });

    testWidgets('should navigate to books home page when auto login returns signed in',
        (WidgetTester widgetTester) async {
      when(() => loadingPageController.autoSignIn()).thenAnswer((_) => Future.value(UserSignInStatus.signedIn));
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LoadingPage), findsOneWidget);
      await widgetTester.pumpAndSettle();

      expect(find.byType(BookHomePage), findsOneWidget);
    });

    testWidgets('should navigate to books home page when auto login returns not verified',
        (WidgetTester widgetTester) async {
      when(() => loadingPageController.autoSignIn()).thenAnswer((_) => Future.value(UserSignInStatus.notVerified));
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LoadingPage), findsOneWidget);
      await widgetTester.pumpAndSettle();

      expect(find.byType(VerifyUserPage), findsOneWidget);
    });
  });
}
