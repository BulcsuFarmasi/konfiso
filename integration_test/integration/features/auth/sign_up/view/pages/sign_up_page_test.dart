import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:konfiso/features/auth/sign_in/controller/sign_in_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_up/view/pages/sign_up_page.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_form.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_initial.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_successful.dart';
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
      return  ProviderScope(
        overrides: [
          signUpStateNotifierProvider.overrideWith((_) => signUpPageStateNotifier),
        ],
        child: const MaterialApp(
          home: SignUpPage(),
        ),
      );
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
        await widgetTester.pumpWidget(createWidgetUnderTest());


        final emailField = find.byKey(SignUpForm.emailKey);
        final passwordField = find.byKey(SignUpForm.passwordKey);
        final otherPasswordField = find.byKey(SignUpForm.otherPasswordKey);
        final button = find.byType(ElevatedButton);

        await widgetTester.enterText(emailField, email);
        await widgetTester.enterText(passwordField, password);
        await widgetTester.enterText(otherPasswordField, password);


        await widgetTester.scrollUntilVisible(button, 300);

        await widgetTester.tap(button);

        // signUpPageStateNotifier.state = const SignUpPageState.inProgress();
        //
        // await widgetTester.pump();
        //
        // expect(find.byType(SignUpInitial), findsOneWidget);
        //
        // signUpPageStateNotifier.state = const SignUpPageState.successful();
        //
        // expect(find.byType(SignUpSuccessful), findsOneWidget);
    });
  });
}
