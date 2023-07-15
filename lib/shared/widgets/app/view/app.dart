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
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    Future(() {
      final notifier = ref.read(appStateNotifierProvider.notifier);
      notifier.setLocale(Platform.localeName);
      notifier.watchConnection();
      notifier.watchDarkMode();
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

    _themeMode = ref.watch(appStateNotifierProvider).maybeMap(
        lightMode: (_) {
          return ThemeMode.light;
        },
        darkMode: (_) {
          return ThemeMode.dark;
        },
        orElse: () => _themeMode);

    AppColors appColors = ref.read(appColorsProvider);
    appColors.themeMode = _themeMode;

    return MaterialApp(
      title: 'Konfiso',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: appColors.backgroundColor,
        brightness: Brightness.light,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: appColors.primaryColor,
          onPrimary: appColors.whiteColor,
          primaryContainer: appColors.primaryColor,
          secondary: appColors.greyColor,
          onSecondary: appColors.whiteColor,
          background: appColors.backgroundColor,
          onBackground: appColors.primaryColor,
          surface: appColors.whiteColor,
          onSurface: appColors.greyDarkestColor,
          error: appColors.primaryColor,
          onError: appColors.whiteColor,
        ),
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(9)),
            fillColor: appColors.inputBackgroundColor,
            filled: true,
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: appColors.primaryColor)),
            errorStyle: TextStyle(color: appColors.primaryColor)),
        filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          backgroundColor: appColors.primaryColor,
        )),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            side: BorderSide(color: appColors.primaryColor),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: appColors.backgroundColor,
          elevation: 0,
          foregroundColor: appColors.greyDarkerColor,
          iconTheme: IconThemeData(color: appColors.greyDarkerColor),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(9)),
            fillColor: appColors.inputBackgroundColor,
            filled: true,
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: appColors.primaryColor)),
            errorStyle: TextStyle(color: appColors.primaryColor)),
        filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          backgroundColor: appColors.primaryColor,
        )),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            side: BorderSide(color: appColors.primaryColor),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: appColors.backgroundColor,
          elevation: 0,
          foregroundColor: appColors.greyDarkerColor,
          iconTheme: IconThemeData(color: appColors.greyDarkerColor),
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
