// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

const blueColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF1C1678),
  onPrimary: Color(0xFFA3FFD6),
  secondary: Color(0xFF134B70),
  onSecondary: Color(0xFFEEEEEE),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF1C1678),
  shadow: Color(0xFF000000),
  outline: Color(0xFF1C1678),
  outlineVariant: Color(0xFF8576FF),
  primaryContainer: Color(0xFF1C1678),
  onPrimaryContainer: Color(0xFFA3FFD6),
  secondaryContainer: Color(0xFF7BC9FF),
  onSecondaryContainer: Color(0xFF1C1678),
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff000000),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFFe2e825),
  primaryFixed: Color(0xff000000),
  onPrimaryFixed: Color(0xFFFFFFFF),
  onSecondary: Color(0xff000000),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xffEEEEEE),
  onSurface: Color(0xff000000),
  shadow: Color(0xFF000000),
  outline: Color(0xff000000),
  outlineVariant: Color(0xFF449e41),
  primaryContainer: Color(0xff78C775),
  onPrimaryContainer: Color(0xff000000),
  secondaryContainer: Color(0xff0B309D),
  onSecondaryContainer: Color(0xFFFFFFFF),
  background: Color(0xFFFFFFFF),
);

const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFFFFF),
    onPrimary: Color(0xFF31363F),
    primaryFixed: Color(0xff000000),
    onPrimaryFixed: Color(0xFFFFFFFF),
    secondary: Color(0xFF31363F),
    onSecondary: Color(0xFFEEEEEE),
    error: Color.fromARGB(255, 255, 0, 0),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFF31363F),
    onSurface: Color(0xFFFFFFFF),
    shadow: Color(0xFFEEEEEE),
    outline: Color(0xFFFFFFFF),
    outlineVariant: Color(0xFFEEE5E9),
    primaryContainer: Color(0xFF97DBDF),
    onPrimaryContainer: Color(0xff222831),
    secondaryContainer: Color(0xFFEEE5E9),
    onSecondaryContainer: Color(0xff222831),
    background: Color.fromARGB(255, 30, 35, 43));

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        lightColorScheme.primary,
      ),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      elevation: WidgetStateProperty.all<double>(5.0),
      padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  primaryTextTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
);

class ThemeConfig {
  static final Map<String, ThemeData> themes = {
    "light": lightMode,
    "dark": darkMode,
    "blue": ThemeData(colorScheme: blueColorScheme),
  };

  static String ConvertToString(ThemeData themeData) {
    if (themeData.colorScheme == darkColorScheme) {
      return "dark";
    } else if (themeData.colorScheme == blueColorScheme) {
      return "blue";
    } else {
      return "light";
    }
  }


}
