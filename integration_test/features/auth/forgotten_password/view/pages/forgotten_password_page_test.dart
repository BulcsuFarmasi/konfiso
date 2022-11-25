import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/auth/forgotten_password/controller/forgotten_password_page_state.dart';
import 'package:konfiso/features/auth/forgotten_password/controller/forgotten_password_page_state_notifier.dart';
import 'package:konfiso/features/auth/forgotten_password/view/pages/forgotten_password_page.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_in_progress.dart';

import 'package:mocktail/mocktail.dart';

class MockForgottenPasswordPageStateNotifier extends StateNotifier<ForgottenPasswordPageState>
    with Mock
    implements ForgottenPasswordPageStateNotifier {
  MockForgottenPasswordPageStateNotifier(super.state);
}

void main() {
  group('ForgottenPasswordPage', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    late ForgottenPasswordPageStateNotifier forgottenPasswordPageStateNotifier;

    setUp(() {
      forgottenPasswordPageStateNotifier =
          MockForgottenPasswordPageStateNotifier(const ForgottenPasswordPageState.initial());
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          forgottenPasswordPageStateNotifierProvider.overrideWith((Ref ref) => forgottenPasswordPageStateNotifier)
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ForgottenPasswordPage(),
        ),
      );
    }

    void arrangeStateNotifierSendEmailReturns() {
      when(forgottenPasswordPageStateNotifier.sendEmail).thenAnswer((_) => Future.value(null));
    }

    testWidgets('should display initial widget initially', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ForgottenPasswordPage), findsOneWidget);
    });

    testWidgets('should display in progress widget after button is tapped', (WidgetTester widgetTester) async {
      // arrange return
      arrangeStateNotifierSendEmailReturns();
      // create env
      await widgetTester.pumpWidget(createWidgetUnderTest());
      // find button
      final button = find.byType(ElevatedButton);
      // tap button
      await widgetTester.tap(button);

      await widgetTester.pump();
      // emit in progress
      forgottenPasswordPageStateNotifier.state = const ForgottenPasswordPageState.inProgress();
      // check if initial is displayed

      await widgetTester.pump();

      expect(find.byType(ForgottenPasswordInProgress), findsOneWidget);
    });

    group('validation', () {
      group('email', () {
        testWidgets('should display error message if email was not put in', (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(createWidgetUnderTest());

          final button = find.byType(ElevatedButton);

          await widgetTester.tap(button);

          await widgetTester.pumpAndSettle();

          expect(find.text('Please provide an Email Address'), findsOneWidget);
        });
        testWidgets('should display error message if an invalid email was put in', (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(createWidgetUnderTest());

          final emailField = find.byType(TextFormField);
          await widgetTester.enterText(emailField, 'test');
          await widgetTester.testTextInput.receiveAction(TextInputAction.done);

          final button = find.byType(ElevatedButton);
          await widgetTester.tap(button);
          await widgetTester.pumpAndSettle();

          expect(find.text('Please put in a valid email address'), findsOneWidget);
        });
        testWidgets('should not display error message if a valid email was put in', (WidgetTester widgetTester) async {
          arrangeStateNotifierSendEmailReturns();

          await widgetTester.pumpWidget(createWidgetUnderTest());

          final emailField = find.byType(TextFormField);
          await widgetTester.enterText(emailField, 'test@test.com');
          await widgetTester.testTextInput.receiveAction(TextInputAction.done);

          final button = find.byType(ElevatedButton);
          await widgetTester.tap(button);
          await widgetTester.pumpAndSettle();

          expect(find.text('Please provide an Email Address'), findsNothing);
          expect(find.text('Please provide a valid email address'), findsNothing);
        });
      });
    });
  });
}
