import 'package:ecommerce_shop/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  String _currentTheme = "light";

  ThemeData get themeData => _themeData;
  String get currentTheme => _currentTheme;

  ThemeProvider() {
    _loadThemeFromPreferences(); // Gọi hàm khởi tạo theme ban đầu
  }

  void toggleTheme(ThemeData theme) async {
    _themeData = theme;
    _currentTheme = ThemeConfig.ConvertToString(theme);
    await _saveThemeToPreferences();
    notifyListeners();
  }

  Future<void> _loadThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _currentTheme = prefs.getString('theme') ?? "light";
    _themeData = ThemeConfig.themes[_currentTheme] ?? lightMode;
    notifyListeners();
  }

  Future<void> _saveThemeToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', _currentTheme);
  }
}
