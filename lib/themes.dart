import 'package:flutter/material.dart';

class AppThemes {
  // Light Mode Colors
  static const backgroundLight = Color.fromARGB(255, 248, 250, 252);
  static final primaryLight = Color.fromARGB(255, 0, 123, 255);
  static final secondaryLight = Color.fromARGB(255, 16, 185, 129);
  static const surfaceLight = Color.fromARGB(255, 255, 255, 255);
  static const mainTextLight = Color.fromARGB(255, 30, 41, 59);

  // Dark Mode Colors
  static const backgroundDark = Color.fromARGB(255, 17, 27, 21);
  static final primaryDark = Color.fromARGB(255, 59, 130, 246);
  static final secondaryDark = Color.fromARGB(255, 52, 211, 153);
  static const surfaceDark = Color.fromARGB(255, 48, 58, 53);
  static const mainTextDark = Color.fromARGB(255, 241, 245, 249);
  static const fieldBackDark = Color.fromARGB(255, 30, 40, 34);
  

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: backgroundLight,
      brightness: Brightness.light,
      primary: primaryLight,
      secondary: secondaryLight,
      surface: surfaceLight
      
    ),
    scaffoldBackgroundColor: backgroundLight,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: backgroundDark,
      brightness: Brightness.dark,
      primary: primaryLight,
      secondary: secondaryDark,
      surface: fieldBackDark,
      surfaceContainer: surfaceDark
    ),
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: AppBarTheme(backgroundColor: backgroundDark,)
  );
}
