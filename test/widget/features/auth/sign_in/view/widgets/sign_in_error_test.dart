import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart'
    as sign_in_error;
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_error.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_error_banner.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_form.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

void main() {
  group('SignInError', () {
    Widget createWidgetUnderTest() {
      return const MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
          child: SignInError(
            error: sign_in_error.SignInError.other,
          ),
        )),
      );
    }

    testWidgets('should find entry logo', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(EntryLogo), findsOneWidget);
    });
    testWidgets('should find sign in error banner',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignInErrorBanner), findsOneWidget);
    });

    testWidgets('should find sign in form', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignInForm), findsOneWidget);
    });
  });
}
