import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'color_schemes.dart';

class Themes {
  static final lightTheme = ThemeData(
    colorScheme: lightColorScheme,
  );
  static final darkTheme = ThemeData(
    colorScheme: darkColorScheme,
  );
}

// Create a theme controller to change the theme of the app
class ThemeController extends ChangeNotifier {
  final _box = Storage();
  final _key = 'isDarkMode';

  // Get the theme mode from the storage
  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;

  // Load the theme from the storage
  bool _loadTheme() => _box.read(_key) ?? false;

  // Save the theme to the storage
  void saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);

  // Toggle the theme
  void changeTheme(ThemeData theme) => notifyListeners();

  // Change theme mode
  void changeThemeMode(ThemeMode themeMode) => notifyListeners();
}

// Define Storage to save the theme
class Storage {
  final Map<String, dynamic> _storage = {};

  void write(String key, dynamic value) {
    _storage[key] = value;
  }

  dynamic read(String key) {
    return _storage[key];
  }
}

class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;
  // final ThemePreferences _themePreferences = ThemePreferences();
  final ThemeController _themeController = ThemeController();

  bool get isDarkMode => _isDarkMode;

  getPreferences() async {
    // _isDarkMode = await _themePreferences.getTheme();
    _isDarkMode = _themeController._loadTheme();
    notifyListeners();
  }

  set isDarkMode(bool value) {
    _isDarkMode = value;
    // _themePreferences.setTheme(value);
    _themeController.saveTheme(value);
    notifyListeners();
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
