import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/loading/controller/loading_page_state_notifier.dart';
import 'package:konfiso/features/loading/view/pages/loading_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<LoadingPageStateNotifier>()])
import 'loading_page_test.mocks.dart';

void main() {
  group('LoadingPage', () {
    late LoadingPageStateNotifier loadingPageStateNotifier;

    Widget createWidgetUinderTest() {
      print(loadingPageStateNotifier);
      return ProviderScope(overrides: [
        loadingPageStateNotifierProvider.overrideWithProvider(
            StateNotifierProvider((_) => loadingPageStateNotifier))
      ], child: const MaterialApp(home: LoadingPage()));
    }

    setUp(() {
      loadingPageStateNotifier = MockLoadingPageStateNotifier();
    });

    testWidgets('should navigate to login page when auto login returns false',
        (WidgetTester widgetTester) async {
      when(loadingPageStateNotifier.autoSignIn())
          .thenAnswer((_) => Future.value(false));
      await widgetTester.pumpWidget(createWidgetUinderTest());
      expect(find.byType(LoadingPage), findsOneWidget);
      widgetTester.pumpAndSettle();
      expect(find.byType(SignInPage), findsOneWidget);
    });
  });
}
