import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/controller/sign_in_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_in/controller/sing_in_page_state.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_form.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_initial.dart';
import 'package:konfiso/features/book/book_home/view/book_home_page.dart';
import 'package:konfiso/shared/widgets/entry_in_progress.dart';

import 'package:mocktail/mocktail.dart';

class MockSignInPageStateNotifier extends StateNotifier<SignInPageState> with Mock
    implements SignInPageStateNotifier {
  MockSignInPageStateNotifier(super.state);
}

void main() {
  group('SignInPageStateNotifier', () {
    late SignInPageStateNotifier signInPageStateNotifier;
    late String email;
    late String password;

    Widget createWidgetUnderTest() {
      return ProviderScope(
          overrides: [
            signInPageNotiferProvider
                .overrideWith((_) => signInPageStateNotifier),
          ],
          child: MaterialApp(home: const SignInPage(), routes: {
            BookHomePage.routeName: (
                BuildContext context) => const BookHomePage()
          }));
    }

    setUp(() {
      signInPageStateNotifier = MockSignInPageStateNotifier(const SignInPageState.initial());

      email = 'test@test.com';
      password = '123456';
    });

    testWidgets(
        'should navigate to books home when the correct sign in data was provided',
            (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(createWidgetUnderTest());
          expect(find.byType(SignInInitial), findsOneWidget);
          final emailField = find.byKey(SignInForm.emailKey);
          final passwordField = find.byKey(SignInForm.passwordKey);
          final button = find.byType(ElevatedButton);

          await widgetTester.enterText(emailField, email);
          await widgetTester.enterText(passwordField, password);

          await widgetTester.tap(button);

          signInPageStateNotifier.state = const SignInPageState.inProgress();

          await widgetTester.pump();

          expect(find.byType(EntryInProgress), findsOneWidget);

          signInPageStateNotifier.state = const SignInPageState.successful();

          await widgetTester.pumpAndSettle();

          expect(find.byType(BookHomePage), findsOneWidget);
        });
  });
}
