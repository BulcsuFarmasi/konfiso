import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/verify_user/controller/verify_user_page_state.dart';
import 'package:konfiso/features/auth/verify_user/controller/verify_user_page_state_notifier.dart';
import 'package:konfiso/features/auth/verify_user/view/pages/verify_user_page.dart';
import 'package:konfiso/features/auth/verify_user/view/widgets/verify_user_initial.dart';
import 'package:mocktail/mocktail.dart';

class MockVerifyUserPageStateNotifier extends StateNotifier<VerifyUserPageState>
    with Mock
    implements VerifyUserPageStateNotifier {
  MockVerifyUserPageStateNotifier(super.state);
}

void main() {
  group('VerifyUserPage', () {
    late VerifyUserPageStateNotifier verifyUserPageStateNotifier;

    setUp(() {
      verifyUserPageStateNotifier =
          MockVerifyUserPageStateNotifier(const VerifyUserPageState.initial());
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          verifyUserPageStateNotifierProvider
              .overrideWith((ref) => verifyUserPageStateNotifier),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: VerifyUserPage(),
        ),
      );
    }

    testWidgets('should contain verify user text',
            (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(createWidgetUnderTest());

          expect(find.text('Verify User'), findsOneWidget);
        });

    testWidgets('should display initial widget if state is initial',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(VerifyUserInitial), findsOneWidget);
    });
  });
}
