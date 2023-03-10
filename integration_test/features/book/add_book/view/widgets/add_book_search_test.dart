import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_page_state_notifier.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_state.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_search.dart';
import 'package:mocktail/mocktail.dart';

class MockAddBookPageStateNotifier extends StateNotifier<AddBookPageState>
    with Mock
    implements AddBookPageStateNotifier {
  MockAddBookPageStateNotifier(super.state);
}

void main() {
  group('AddBookSearch', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    late AddBookPageStateNotifier addBookPageStateNotifier;

    setUp(() {
      addBookPageStateNotifier = MockAddBookPageStateNotifier(const AddBookPageState.initial());
    });

    Widget createWidgetUnderTest([VoidCallback? callback]) {
      return ProviderScope(
        overrides: [
          addBookPageStateNotifierProvider.overrideWith((_) => addBookPageStateNotifier),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: AddBookSearch(onFocus: callback ?? () {})),
        ),
      );
    }

    testWidgets('should call state notifier search function after typing', (WidgetTester widgetTester) async {
      const testText = 'apple';
      await widgetTester.pumpWidget(createWidgetUnderTest());

      final textField = find.byType(TextField);
      await widgetTester.enterText(textField, testText);
      await widgetTester.pump(const Duration(milliseconds: 250));

      verify(() => addBookPageStateNotifier.search(testText));
    });

    testWidgets('should call startedTyping callback after callback', (WidgetTester widgetTester) async {
      const testText = 'alma';
      final completer = Completer();

      await widgetTester.pumpWidget(createWidgetUnderTest(completer.complete));
      final textField = find.byType(TextField);
      await widgetTester.enterText(textField, testText);
      await widgetTester.pump(const Duration(milliseconds: 250));

      expectLater(completer.isCompleted, isTrue);
    });
  });
}
