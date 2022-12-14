import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/forgotten_password/view/pages/forgotten_password_page.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/auth/sign_up/view/pages/sign_up_page.dart';
import 'package:konfiso/features/auth/verify_user/view/pages/verify_user_page.dart';
import 'package:konfiso/features/book/add_book/view/pages/add_book_page.dart';
import 'package:konfiso/features/book/book_category/view/pages/book_category_page.dart';
import 'package:konfiso/features/book/book_detail/view/pages/book_detail_page.dart';
import 'package:konfiso/features/book/book_home/view/pages/book_home_page.dart';
import 'package:konfiso/features/loading/view/pages/loading_page.dart';
import 'package:konfiso/features/no_connection/view/pages/no_connection_page.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:konfiso/shared/widgets/app/controller/app_state.dart';
import 'package:konfiso/shared/widgets/app/controller/app_state_notifier.dart';

final routeObserver = RouteObserver<ModalRoute<void>>();

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    Future(() {
      final notifier = ref.read(appStateNotifierProvider.notifier);
      notifier.setLocale(Platform.localeName);
      notifier.watchConnection();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(appStateNotifierProvider, (AppState? previous, AppState next) {
      next.maybeMap(
          connected: (_) {
            if (previous != const AppState.initial()) {
              _navigatorKey.currentState!.pop();
            }
          },
          notConnected: (_) {
            _navigatorKey.currentState!.pushNamed(NoConnectionPage.routeName);
          },
          orElse: () => null);
    });
    return MaterialApp(
      title: 'Konfiso',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: _navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        primarySwatch: AppColors.primaryColorSwatch,
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(9)),
            fillColor: AppColors.inputBackgroundColor,
            filled: true,
            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
            errorStyle: const TextStyle(color: AppColors.primaryColor)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)), elevation: 0),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            side: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          foregroundColor: AppColors.greyDarkerColor,
          iconTheme: IconThemeData(color: AppColors.greyDarkerColor),
        ),
      ),
      navigatorObservers: [routeObserver],
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const LoadingPage(),
        SignInPage.routeName: (BuildContext context) => const SignInPage(),
        SignUpPage.routeName: (BuildContext context) => const SignUpPage(),
        VerifyUserPage.routeName: (BuildContext context) => const VerifyUserPage(),
        ForgottenPasswordPage.routeName: (BuildContext context) => const ForgottenPasswordPage(),
        BookHomePage.routeName: (BuildContext context) => const BookHomePage(),
        BookCategoryPage.routeName: (BuildContext context) => const BookCategoryPage(),
        AddBookPage.routeName: (BuildContext context) => const AddBookPage(),
        BookDetailPage.routeName: (BuildContext context) => const BookDetailPage(),
        NoConnectionPage.routeName: (BuildContext context) => const NoConnectionPage(),
      },
    );
  }
}
