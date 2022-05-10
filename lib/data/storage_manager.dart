import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static const _keyTheme = "theme";

  static Future<bool> isDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyTheme) ?? true;
  }

  static void setIsDarkTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_keyTheme, isDarkTheme);
  }
}
