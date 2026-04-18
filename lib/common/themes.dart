import 'package:flutter/material.dart';

import 'colors.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: TechStarsColors.primary,
    primaryColorDark: TechStarsColors.primaryDark,
    scaffoldBackgroundColor: TechStarsColors.background,
    fontFamily: "AlbertSans",
    appBarTheme: const AppBarTheme(
      backgroundColor: TechStarsColors.background,
      foregroundColor: TechStarsColors.textPrimary,
      surfaceTintColor: Colors.black12,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: TechStarsColors.primary),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: TechStarsColors.primaryDark,
    primaryColorDark: TechStarsColors.primary,
    scaffoldBackgroundColor: TechStarsColors.background,
    fontFamily: "AlbertSans",
    appBarTheme: const AppBarTheme(
      backgroundColor: TechStarsColors.background,
      foregroundColor: Colors.white10,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: TechStarsColors.primaryDark),
  );
}
