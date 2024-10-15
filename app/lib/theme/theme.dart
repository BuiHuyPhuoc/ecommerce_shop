// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff000000),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFFe2e825),
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
  primary: Color(0xFF222831),
  onPrimary: Color(0xFFEEEEEE),
  secondary: Color(0xFF31363F),
  onSecondary: Color(0xFFEEEEEE),
  error: Color.fromARGB(255, 255, 0, 0),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFF31363F),
  onSurface: Color(0xFFEEEEEE),
  shadow: Color(0xFFEEEEEE),
  outline: Color(0xFFEEEEEE),
  outlineVariant: Color(0xFF76ABAE),
  primaryContainer: Color(0xFF222831),
  onPrimaryContainer: Color(0xFFEEEEEE),
  secondaryContainer: Color(0xFF31363F),
  onSecondaryContainer: Color(0xFFEEEEEE),
  background: Color(0xff31363F)
);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        lightColorScheme.primary,
      ),
      foregroundColor:
          WidgetStateProperty.all<Color>(Colors.white),
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