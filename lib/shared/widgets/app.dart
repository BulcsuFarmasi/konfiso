import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/book/book_home/view/book_home_page.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/auth/sign_up/view/pages/sign_up_page.dart';
import 'package:konfiso/shared/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Konfiso',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          primarySwatch: AppColors.primaryColorSwatch,
          fontFamily: 'Poppins',
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(9)),
              fillColor: AppColors.inputBackgroundColor,
              filled: true,
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(AppColors.primaryColor))),
              errorStyle: const TextStyle(color: Color(AppColors.primaryColor))),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
              elevation: 0
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => const SignInPage(),
          SignInPage.routeName: (BuildContext context) => const SignInPage(),
          SignUpPage.routeName: (BuildContext context) => const SignUpPage(),
          BookHomePage.routeName: (BuildContext context) => const BookHomePage(),
        },
      ),
    );
  }
}
