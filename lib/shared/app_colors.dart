import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<AppColors> appColorsProvider = Provider<AppColors>((Ref ref) => AppColors());

class AppColors {

  ThemeMode themeMode = ThemeMode.light;

  static const int _primaryColorValue = 0xFFFA4005;

  Color primaryColor = const Color(_primaryColorValue);

  Color get backgroundColor => themeMode == ThemeMode.light ? const Color(0xFFE5E5E5) :  const Color(0xFF121212);

  Color get inputBackgroundColor => themeMode == ThemeMode.light ? const Color(0xFFF7F7F7) :  const Color(0xFF242424);

  Color greyColor = const Color(0xFF969696);

  Color greyDarkerColor = const Color(0xFF323232);

  Color greyDarkestColor = const Color(0xFF06070D);

  Color greyDarkestWithHalfOpacity = const Color(0x7F06070D);

  Color blackColor = const Color(0xFF000000);

  Color whiteColor = Colors.white;
}
