import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppThemes {
  // Light Mode Colors
  static const backgroundLight = Color.fromARGB(255, 248, 250, 252);
  static final primaryLight = Color.fromARGB(255, 0, 189, 142);
  static final secondaryLight = Color.fromARGB(255, 16, 185, 129);
  static const surfaceLight = Color.fromARGB(255, 221, 220, 220);
  static const mainTextLight = Color.fromARGB(255, 30, 41, 59);
  static const fieldBackLight = Color.fromARGB(255, 225, 224, 224);

  // Dark Mode Colors
  static const backgroundDark = Color.fromARGB(255, 11, 17, 14);
  static final primaryDark = Color.fromARGB(255, 2, 148, 111);
  static final secondaryDark = Color.fromARGB(255, 52, 211, 153);
  static const surfaceDark = Color.fromARGB(255, 33, 40, 36);
  static const mainTextDark = Color.fromARGB(255, 241, 245, 249);
  static const fieldBackDark = Color.fromARGB(255, 36, 42, 38);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: backgroundLight,
      brightness: Brightness.light,
      primary: primaryLight,
      secondary: secondaryLight,
      surface: surfaceLight,
    ),
    scaffoldBackgroundColor: backgroundLight,
     elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primaryLight),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
    )
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: backgroundDark,
      brightness: Brightness.dark,
      primary: primaryDark,
      secondary: secondaryDark,
      surface: surfaceDark,
      surfaceContainer: fieldBackDark,
    ),
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: AppBarTheme(backgroundColor: backgroundDark),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primaryDark),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
    ),
  );
}

void showToast(
  String title,
  String message,
  ToastificationType type,
  BuildContext context,
) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final backColor = isDarkMode
      ? const Color.fromARGB(255, 35, 35, 35)
      : Colors.white;
  final borderColor = isDarkMode
      ? const Color.fromARGB(155, 73, 73, 73)
      : const Color.fromARGB(255, 168, 168, 168);
  toastification.show(
    context: context,
    title: Text(title),
    description: Text(message),
    autoCloseDuration: const Duration(seconds: 3),
    type: type,
    backgroundColor: backColor,
    foregroundColor: Theme.of(context).colorScheme.onSurface,
    borderSide: BorderSide(color: borderColor, width: 1),
  );
}
