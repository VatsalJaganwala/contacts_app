import 'package:flutter/material.dart';

import '../../app/constants/color_const.dart';

class AppTheme {
  //LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ColorConst.kPrimary,
      onPrimary: Colors.white,
      secondary: ColorConst.kSecondary,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),

    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorConst.kPrimary,
      foregroundColor: Colors.white,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: ColorConst.kPrimary,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  //DARK THEME
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: ColorConst.kPrimaryDark,
      onPrimary: Colors.black,
      secondary: ColorConst.kSecondaryDark,
      onSecondary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.black,
      surface: ColorConst.kSurfaceDark,
      onSurface: Colors.white,
    ),

    scaffoldBackgroundColor: ColorConst.kBackgroundDark,

    appBarTheme: const AppBarTheme(
      backgroundColor: ColorConst.kSurfaceDark,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorConst.kPrimaryDark,
      foregroundColor: Colors.black,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorConst.kSurfaceDark,
      selectedItemColor: ColorConst.kPrimaryDark,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorConst.kSurfaceDark,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
