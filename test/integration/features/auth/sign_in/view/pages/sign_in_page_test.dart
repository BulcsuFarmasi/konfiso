import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/controller/sign_in_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_in/controller/sing_in_page_state.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_initial.dart';
import 'package:konfiso/features/book/book_home/view/book_home_page.dart';

import 'package:mocktail/mocktail.dart';

class MockSignInPageStateNotifier extends Mock
    implements SignInPageStateNotifier {}

void main() {
  group('SignInPageStateNotifier', skip: 'find out', () {
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
            BookHomePage.routeName: (BuildContext context) =>
                const BookHomePage()
          }));
    }

    setUp(() {
      signInPageStateNotifier = MockSignInPageStateNotifier();
      email = 'test@test.com';
      password = '123456';
    });

    testWidgets(
        'should navigate to books home when the correct sign in data was provided',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());
      when(() => signInPageStateNotifier.state)
          .thenAnswer((_) => const SignInPageState.initial());
      expect(find.byType(SignInInitial), findsOneWidget);
    });
  });
}
