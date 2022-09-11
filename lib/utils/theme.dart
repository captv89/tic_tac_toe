import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learning_ui/utils/color_schemes.dart';

class Themes {
  static final lightTheme = ThemeData(
    colorScheme: lightColorScheme,
  );
  static final darkTheme = ThemeData(
    colorScheme: darkColorScheme,
  );
}

class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;
  final ThemePreferences _themePreferences = ThemePreferences();

  getPreferences() async {
    _isDarkMode = await _themePreferences.getTheme();
    notifyListeners();
  }

  set isDarkMode(bool value) {
    _isDarkMode = value;
    _themePreferences.setTheme(value);
    notifyListeners();
  }

  bool get isDarkMode {
    getPreferences();
    return _isDarkMode;
  }
}

class ThemePreferences {
  static const themeStatus = 'theme_status';

  setTheme(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(themeStatus, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(themeStatus) ?? false;
  }
}

class Scores {
  // Save scores to shared preferences
  Future<void> saveScores(int xScore, int oScore) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('xScore', xScore);
    prefs.setInt('oScore', oScore);
  }

  Future<List> loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    var xScore = prefs.getInt('xScore') ?? 0;
    var oScore = prefs.getInt('oScore') ?? 0;

    return [xScore, oScore];
  }

  Future resetScores() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('xScore', 0);
    prefs.setInt('oScore', 0);
  }
}
