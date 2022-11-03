import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_up/view/pages/sign_up_page.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_form.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_initial.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_successful.dart';
import 'package:konfiso/shared/widgets/entry_in_progress.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpPageStateNotifier extends StateNotifier<SignUpPageState>
    with Mock
    implements SignUpPageStateNotifier {
  MockSignUpPageStateNotifier(super.state);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('SignUpPage', () {
    late SignUpPageStateNotifier signUpPageStateNotifier;
    late String email;
    late String password;

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          signUpStateNotifierProvider
              .overrideWith((_) => signUpPageStateNotifier),
        ],
        child: const MaterialApp(
          home: SignUpPage(),
        ),
      );
    }

    Future<void> testUntilInProgress(WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      final emailField = find.byKey(SignUpForm.emailKey);
      final passwordField = find.byKey(SignUpForm.passwordKey);
      final otherPasswordField = find.byKey(SignUpForm.otherPasswordKey);
      final button = find.byType(ElevatedButton);

      await widgetTester.enterText(emailField, email);
      await widgetTester.enterText(passwordField, password);
      await widgetTester.enterText(otherPasswordField, password);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(button);

      signUpPageStateNotifier.state = const SignUpPageState.inProgress();

      await widgetTester.pump();

      expect(find.byType(EntryInProgress), findsOneWidget);
    }

    setUp(() {
      signUpPageStateNotifier =
          MockSignUpPageStateNotifier(const SignUpPageState.initial());
      email = 'test@test.com';
      password = '123456';
    });

    testWidgets('initially should be in initial state',
            (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(createWidgetUnderTest());

          expect(find.byType(SignUpInitial), findsOneWidget);
        });

    testWidgets('should reach success state when the sign up is successful',
            (WidgetTester widgetTester) async {
          await testUntilInProgress(widgetTester);

          signUpPageStateNotifier.state = const SignUpPageState.successful();

          await widgetTester.pump();

          expect(find.byType(SignUpSuccessful), findsOneWidget);
        });

    testWidgets('should reach error state when the sign up is not successful',
            (WidgetTester widgetTester) async {
          await testUntilInProgress(widgetTester);
          signUpPageStateNotifier.state = const SignUpPageState.successful();

          await widgetTester.pump();

          expect(find.byType(SignUpSuccessful), findsOneWidget);
        });

    group('validation', () {
      group('email', () {
        testWidgets('should display error message if email was not put in', (
            WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(createWidgetUnderTest());

          final button = find.byType(ElevatedButton);

          await widgetTester.tap(button);

          await widgetTester.pumpAndSettle();

          expect(find.text('Please write an email address'), findsOneWidget);
        });
      });
      testWidgets(
          'should display error message if an invalid email was put in', (
          WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(createWidgetUnderTest());

        final emailField = find.byKey(SignUpForm.emailKey);
        await widgetTester.enterText(emailField, 'test');
        await widgetTester.testTextInput.receiveAction(TextInputAction.done);

        final button = find.byType(ElevatedButton);
        await widgetTester.tap(button);
        await widgetTester.pumpAndSettle();

        expect(
            find.text('Please put in a valid email address'), findsOneWidget);
      });
      testWidgets(
          'should not display error message if a valid email was put in',
              (WidgetTester widgetTester) async {
            await widgetTester.pumpWidget(createWidgetUnderTest());

            final emailField = find.byKey(SignUpForm.emailKey);
            await widgetTester.enterText(emailField, email);
            await widgetTester.testTextInput.receiveAction(
                TextInputAction.done);

            final button = find.byType(ElevatedButton);
            await widgetTester.tap(button);
            await widgetTester.pumpAndSettle();

            expect(find.text('Please write an email address'), findsNothing);
            expect(
                find.text('Please put in a valid email address'), findsNothing);
          });
      group('password', () {
        testWidgets('should display error message if password was not put in', (
            WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(createWidgetUnderTest());

          final button = find.byType(ElevatedButton);

          await widgetTester.tap(button);

          await widgetTester.pumpAndSettle();

          expect(find.text('Please write a password'), findsOneWidget);
        });
      });
      testWidgets(
          'should display error message if a too short password was put in', (
          WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(createWidgetUnderTest());

        final passwordField = find.byKey(SignUpForm.passwordKey);
        await widgetTester.enterText(passwordField, '12345');
        await widgetTester.testTextInput.receiveAction(TextInputAction.done);

        final button = find.byType(ElevatedButton);
        await widgetTester.tap(button);
        await widgetTester.pumpAndSettle();

        expect(
            find.text('Please write at least 6 characters'), findsOneWidget);
      });
      testWidgets(
          'should not display error message if a valid password was put in',
              (WidgetTester widgetTester) async {
            await widgetTester.pumpWidget(createWidgetUnderTest());

            final passwordField = find.byKey(SignUpForm.passwordKey);
            await widgetTester.enterText(passwordField, password);
            await widgetTester.testTextInput.receiveAction(
                TextInputAction.done);

            final button = find.byType(ElevatedButton);
            await widgetTester.tap(button);
            await widgetTester.pumpAndSettle();

            expect(find.text('Please write a password'), findsNothing);
            expect(
                find.text('Please write at least 6 characters'), findsNothing);
          });
    });
    group('other password', () {
      testWidgets('should display an error message if the passwords don\'t match', (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(createWidgetUnderTest());

        final passwordField = find.byKey(SignUpForm.passwordKey);
        final otherPasswordField = find.byKey(SignUpForm.otherPasswordKey);
        final button = find.byType(ElevatedButton);

        await widgetTester.enterText(passwordField, password);
        await widgetTester.enterText(otherPasswordField, '$password-');
        await widgetTester.testTextInput.receiveAction(TextInputAction.done);
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(button);

        await widgetTester.pumpAndSettle();

        expect(find.text('Please write identical passwords'), findsOneWidget);
      });

      testWidgets('should display an error message if the passwords don\'t match', (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(createWidgetUnderTest());

        final passwordField = find.byKey(SignUpForm.passwordKey);
        final otherPasswordField = find.byKey(SignUpForm.otherPasswordKey);
        final button = find.byType(ElevatedButton);

        await widgetTester.enterText(passwordField, password);
        await widgetTester.enterText(otherPasswordField, password);
        await widgetTester.testTextInput.receiveAction(TextInputAction.done);
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(button);

        await widgetTester.pumpAndSettle();

        expect(find.text('Please write identical passwords'), findsNothing);
      });
    });
  });
}
