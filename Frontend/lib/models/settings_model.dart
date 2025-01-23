import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _isLoggedIn = false;
  String _userEmail = 'user@example.com';

  ThemeMode get themeMode => _themeMode;
  bool get isLoggedIn => _isLoggedIn;
  String get userEmail => _userEmail;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
  void loginUser(String email) {
    _isLoggedIn = true;
    _userEmail = email;
    notifyListeners();
  }

  void logoutUser() {
    _isLoggedIn = false;
    _userEmail = '';
    notifyListeners();
  }
}
