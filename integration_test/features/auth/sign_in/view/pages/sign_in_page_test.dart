import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:konfiso/features/auth/sign_in/controller/sign_in_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_in/controller/sing_in_page_state.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart'
    as model_sign_in_error;
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_error.dart'
    as view_sign_in_error;
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_error_banner.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_form.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_initial.dart';
import 'package:konfiso/features/auth/sign_up/view/pages/sign_up_page.dart';
import 'package:konfiso/features/book/book_home/view/pages/book_home_page.dart';
import 'package:konfiso/shared/widgets/entry_in_progress.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mocktail/mocktail.dart';

class MockSignInPageStateNotifier extends StateNotifier<SignInPageState>
    with Mock
    implements SignInPageStateNotifier {
  MockSignInPageStateNotifier(super.state);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('SignInPage', () {
    late SignInPageStateNotifier signInPageStateNotifier;
    late String email;
    late String password;

    Widget createWidgetUnderTest() {
      return ProviderScope(
          overrides: [
            signInPageNotiferProvider
                .overrideWith((_) => signInPageStateNotifier),
          ],
          child: MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const SignInPage(),
              routes: {
                BookHomePage.routeName: (BuildContext context) =>
                    const BookHomePage(),
                SignUpPage.routeName: (BuildContext context) =>
                    const SignUpPage(),
              }));
    }

    Future<void> testUntilInProgress(WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      final emailField = find.byKey(SignInForm.emailKey);
      final passwordField = find.byKey(SignInForm.passwordKey);
      final button = find.byType(ElevatedButton);

      await widgetTester.enterText(emailField, email);
      await widgetTester.enterText(passwordField, password);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(button);

      signInPageStateNotifier.state = const SignInPageState.inProgress();

      await widgetTester.pump();

      expect(find.byType(EntryInProgress), findsOneWidget);
    }

    setUp(() {
      signInPageStateNotifier =
          MockSignInPageStateNotifier(const SignInPageState.initial());

      email = 'test@test.com';
      password = '123456';
    });

    testWidgets('initially should be in initial state',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignInInitial), findsOneWidget);
    });

    testWidgets(
        'should navigate to books home page when the correct sign in data was provided',
        (WidgetTester widgetTester) async {
      await testUntilInProgress(widgetTester);

      signInPageStateNotifier.state = const SignInPageState.successful();

      await widgetTester.pumpAndSettle();

      expect(find.byType(BookHomePage), findsOneWidget);
    });

    testWidgets('should display error and error banner widgets',
        (WidgetTester widgetTester) async {
      await testUntilInProgress(widgetTester);

      signInPageStateNotifier.state =
          const SignInPageState.error(model_sign_in_error.SignInError.other);

      await widgetTester.pumpAndSettle();

      expect(find.byType(view_sign_in_error.SignInError), findsOneWidget);

      expect(find.byType(SignInErrorBanner), findsOneWidget);
    });

    testWidgets('should navigate to sign up by clicking the link',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      final link = find.text('sign up');

      await widgetTester.tap(link);

      await widgetTester.pumpAndSettle();

      expect(find.byType(SignUpPage), findsOneWidget);
    });

    group('validation', () {
      group('email', () {
        testWidgets(
            'should check if email is not not put in, validation message is displayed',
            (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(createWidgetUnderTest());

          final button = find.byType(ElevatedButton);

          await widgetTester.tap(button);

          await widgetTester.pumpAndSettle();

          expect(find.text('Please provide an Email Address'), findsOneWidget);
        });
        testWidgets(
            'should check if email is put in, validation message is NOT displayed',
            (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(createWidgetUnderTest());

          final emailField = find.byKey(SignInForm.emailKey);

          final button = find.byType(ElevatedButton);

          await widgetTester.enterText(emailField, email);
          await widgetTester.testTextInput.receiveAction(TextInputAction.done);
          await widgetTester.pumpAndSettle();

          await widgetTester.tap(button);

          await widgetTester.pumpAndSettle();

          expect(find.text('Please provide an email address'), findsNothing);
        });
      });
      group('password', () {
        testWidgets(
            'should check if password is not not put in, validation message is displayed',
            (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(createWidgetUnderTest());

          final button = find.byType(ElevatedButton);

          await widgetTester.tap(button);

          await widgetTester.pumpAndSettle();

          expect(find.text('Please provide a password'), findsOneWidget);
        });
      });
      testWidgets(
          'should check if password is put in, validation message is NOT displayed',
          (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(createWidgetUnderTest());

        final passwordField = find.byKey(SignInForm.passwordKey);

        final button = find.byType(ElevatedButton);

        await widgetTester.enterText(passwordField, password);
        await widgetTester.testTextInput.receiveAction(TextInputAction.done);
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(button);

        await widgetTester.pumpAndSettle();

        expect(find.text('Please provide an password'), findsNothing);
      });
    });
  });
}
