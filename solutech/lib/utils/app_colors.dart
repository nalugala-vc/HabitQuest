import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color plainWhite = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF001414);
  static const Color pink100 = Color(0XFFFEF3FF);
  static const Color pink400 = Color(0XFFF3CDE2);
  static const Color purple100 = Color(0XFFEDE1F8);
  static const Color purple400 = Color(0XFFD6C2EB);
  static const Color purple500 = Color(0XFFc8add9);
  static const Color purple600 = Color.fromARGB(255, 172, 144, 203);
  static const Color purple630 = const Color.fromARGB(255, 149, 121, 168);
  static const Color purple650 = Color(0XFFa790b5);
  static const Color purple750 = Color(0XFF857391);
  static const Color peach200 = Color(0XFFEBD8D0);
  static const Color grey500 = Color(0XFF757575);
  static const Color grey600 = Color(0XFF909090);
  static const Color grey50 = Color(0XFFFBFBFB);
  static const Color grey40 = Color(0XFFF5F5F5);
  static const Color grey400 = Color(0XFF9E9E9E);
  static const Color grey300 = Color(0XFFE0E0E0);
  static const Color grey200 = Color(0XFFEEEEEE);
  static const Color grey100 = Color(0XFFF5F5F5);
  static const Color grey700 = Color(0XFF616161);
  static const Color grey800 = Color(0XFF424242);
  static const Color grey900 = Color(0XFF212121);
  static const Color red400 = Color(0XFFFF0000);

  // Dark Mode Colors
  static const Color darkPlainWhite = Color(0xFF1A1A1A);
  static const Color darkBlack = Color(0xFFE6EBEB);
  static const Color darkPink100 = Color(0XFF4D0C4D);
  static const Color darkPink400 = Color(0XFF5C324D);
  static const Color darkPurple100 = Color(0XFF322047);
  static const Color darkPurple400 = Color(0XFF493D54);
  static const Color darkPurple500 = Color(0XFF574C66);
  static const Color darkPurple600 = Color(0XFF736F84);
  static const Color darkPurple650 = Color(0XFF786F8A);
  static const Color darkPurple750 = Color(0XFF9A8CAE);
  static const Color darkPeach200 = Color(0XFF54272F);
  static const Color darkGrey500 = Color(0XFF8A8A8A);
  static const Color darkGrey600 = Color(0XFF6F6F6F);
  static const Color darkGrey50 = Color(0XFF040404);
  static const Color darkGrey40 = Color(0XFF0A0A0A);
  static const Color darkGrey400 = Color(0XFF616161);
  static const Color darkGrey300 = Color(0XFF1F1F1F);
  static const Color darkGrey200 = Color(0XFF111111);
  static const Color darkGrey100 = Color(0XFF0A0A0A);
  static const Color darkGrey700 = Color(0XFF9E9E9E);
  static const Color darkGrey800 = Color(0XFFBDBDBD);
  static const Color darkGrey900 = Color(0XFFDEDEDE);
  static const Color darkRed400 = Color(0XFF8B0000);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        surface: plainWhite,
        primary: purple500,
        shadow: pink100,
        error: red400,
        onSurface: purple400,
        secondary: pink400,
        onPrimary: grey600,
        onSecondary: grey300,
        onTertiary: purple100,
        onPrimaryContainer: purple600,
        onSecondaryContainer: grey400,
        onSurfaceVariant: black,
        outline: purple630,
        onTertiaryFixed: grey900,
        onSecondaryFixed: grey500,
        onPrimaryFixedVariant: grey200,
        secondaryFixedDim: purple750,
        onInverseSurface: grey700,
        primaryFixed: peach200),
    scaffoldBackgroundColor: plainWhite,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
        surface: darkPlainWhite,
        primary: darkPurple500,
        error: darkRed400,
        onSurface: darkPurple400,
        secondary: darkPink400,
        onSecondary: darkGrey300,
        shadow: darkPink100,
        onPrimary: darkGrey600,
        onTertiary: darkPurple100,
        onTertiaryFixed: darkGrey900,
        onPrimaryContainer: darkPurple600,
        onSecondaryContainer: darkGrey400,
        onSurfaceVariant: darkBlack,
        outline: darkPurple600,
        onSecondaryFixed: darkGrey500,
        onPrimaryFixedVariant: darkGrey200,
        secondaryFixedDim: darkPurple750,
        onInverseSurface: darkGrey700,
        primaryFixed: darkPeach200),
    scaffoldBackgroundColor: darkPlainWhite,
  );
}
