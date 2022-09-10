import 'package:flutter/material.dart';
import 'package:konfiso/features/sign_up/view/sign_up_page.dart';
import 'package:konfiso/shared/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konfiso',
      home: const SignUpPage(),
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          primarySwatch: AppColors.primaryColorSwatch,
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(9)),
              fillColor: AppColors.inputBackgroundColor,
              filled: true,
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(AppColors.primaryColor))),
              errorStyle:
                  const TextStyle(color: Color(AppColors.primaryColor)))),
    );
  }
}
