import 'package:flutter/material.dart';
import '../utils/theme.dart'; 

class ThemeProvider extends ChangeNotifier {
bool _isDarkMode = false;

bool get isDarkMode => _isDarkMode;

ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

String get themeString => _isDarkMode ? "dark" : "light"; 


  void setLightTheme() {
    _isDarkMode = false;
    notifyListeners();
  }

  void setDarkTheme() {
    _isDarkMode = true;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
