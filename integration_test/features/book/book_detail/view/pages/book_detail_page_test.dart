import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state.dart';
import 'package:konfiso/features/book/book_detail/controller/book_detail_page_state_notifier.dart';
import 'package:konfiso/features/book/book_detail/view/pages/book_detail_page.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_in_progress.dart';
import 'package:konfiso/features/book/book_detail/view/widgets/book_detail_success.dart';
import 'package:konfiso/features/book/model/book.dart';
import 'package:konfiso/features/book/model/book_ids.dart';
import 'package:mocktail/mocktail.dart';

class MockBookDetailPageStateNotifier extends StateNotifier<BookDetailPageState>
    with Mock
    implements BookDetailPageStateNotifier {
  MockBookDetailPageStateNotifier(super.state);
}

void main() {
  group('BookDetailPage', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    late BookDetailPageStateNotifier bookDetailPageStateNotifier;

    setUp(() {
      bookDetailPageStateNotifier =
          MockBookDetailPageStateNotifier(const BookDetailPageState.initial());
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          bookDetailPageStateNotifierProvider
              .overrideWith((_) => bookDetailPageStateNotifier),
        ],
        child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: BookDetailPage()),
      );
    }

    Future<void> loadWidgetAndSetStateToInProgress(
        WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      bookDetailPageStateNotifier.state =
          const BookDetailPageState.inProgress();
      await widgetTester.pump();
    }

    testWidgets(
        'should display in Progress if in Progress was emitted by state notifier',
        (WidgetTester widgetTester) async {
      await loadWidgetAndSetStateToInProgress(widgetTester);

      expect(find.byType(BookDetailInProgress), findsOneWidget);
    });

    testWidgets(
        'should display successful if successful was emitted by state notifier',
        (WidgetTester widgetTester) async {
      await loadWidgetAndSetStateToInProgress(widgetTester);
      bookDetailPageStateNotifier.state =
          const BookDetailPageState.success(Book(title: 'a', externalId: 'b'));
      await widgetTester.pump();

      expect(find.byType(BookDetailSuccess), findsOneWidget);
    });
  });
}
