import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<AppColors> appColorsProvider = Provider<AppColors>((Ref ref) => AppColors());

class AppColors {

  ThemeMode themeMode = ThemeMode.light;

  static const int _primaryColorValue = 0xFFFA4005;

  Color primaryColor = const Color(_primaryColorValue);

  Color get backgroundColor => themeMode == ThemeMode.light ? const Color(0xFFE5E5E5) :  const Color(0xFF363636);

  Color get inputBackgroundColor => themeMode == ThemeMode.light ? const Color(0xFFF7F7F7) :  const Color(0xFF484848);

  Color get surfaceColor => themeMode == ThemeMode.light ? const Color(0xFFFFFFFF) : const Color(0xFF606060);


  Color get smallEmphasisText => themeMode == ThemeMode.light ? const Color(0xFF969696) :  const Color(0x60FFFFFF);

  Color get mediumEmphasisText => themeMode == ThemeMode.light ? const Color(0xFF323232) :  const Color(0x99FFFFFF);

  Color get highEmphasisText => themeMode == ThemeMode.light ? const Color(0x7F06070D) :  const Color(0xBAFFFFFF);

  Color get higherEmphasisText => themeMode == ThemeMode.light ? const Color(0xFF06070D) :  const Color(0xDBFFFFFF);

  Color whiteColor = const Color(0xFFFFFFFF);
}
