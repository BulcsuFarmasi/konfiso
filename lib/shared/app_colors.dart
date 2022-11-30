import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primaryColorSwatch = MaterialColor(_primaryColorValue, <int, Color>{
    50: Color(0xFFFEE8E1),
    100: Color(0xFFFEC6B4),
    200: Color(0xFFFDA082),
    300: Color(0xFFFC7950),
    400: Color(0xFFFB5D2B),
    500: Color(_primaryColorValue),
    600: Color(0xFFF93A04),
    700: Color(0xFFF93204),
    800: Color(0xFFF82A03),
    900: Color(0xFFF61C01),
  });
  static const int _primaryColorValue = 0xFFFA4005;

  static const Color primaryColor = Color(_primaryColorValue);

  static const backgroundColor = Color(0xFFE5E5E5);

  static const inputBackgroundColor = Color(0xFFF7F7F7);

  static const greyColor = Color(0xFF969696);

  static const greyDarkerColor = Color(0xFF323232);

  static const greyDarkestColor = Color(0xFF06070D);

  static const greyDarkestWithHalfOpacity = Color(0x7F06070D);

  static const blackColor = Color(0xFF000000);
}
