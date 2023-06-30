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
import 'package:konfiso/features/no_connection/no_connection/view/pages/no_connection_page.dart';
import 'package:konfiso/features/settings/settings/view/pages/settings_page.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        canvasColor: AppColors.backgroundColor,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primaryColor,
          onPrimary: AppColors.whiteColor,
          primaryContainer: AppColors.primaryColor,
          secondary: AppColors.greyColor,
          onSecondary: AppColors.whiteColor,
          background: AppColors.backgroundColor,
          onBackground: AppColors.primaryColor,
          surface: AppColors.whiteColor,
          onSurface: AppColors.greyDarkestColor,
          error: AppColors.primaryColor,
          onError: AppColors.whiteColor,
        ),
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(9)),
            fillColor: AppColors.inputBackgroundColor,
            filled: true,
            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
            errorStyle: const TextStyle(color: AppColors.primaryColor)),
        filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          backgroundColor: AppColors.primaryColor,
        )),
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
        '/': (_) => const LoadingPage(),
        SignInPage.routeName: (_) => const SignInPage(),
        SignUpPage.routeName: (_) => const SignUpPage(),
        VerifyUserPage.routeName: (_) => const VerifyUserPage(),
        ForgottenPasswordPage.routeName: (_) => const ForgottenPasswordPage(),
        BookHomePage.routeName: (_) => const BookHomePage(),
        BookCategoryPage.routeName: (_) => const BookCategoryPage(),
        AddBookPage.routeName: (_) => const AddBookPage(),
        BookDetailPage.routeName: (_) => const BookDetailPage(),
        NoConnectionPage.routeName: (_) => const NoConnectionPage(),
        SettingsPage.routeName: (_) => const SettingsPage(),
      },
    );
  }
}
