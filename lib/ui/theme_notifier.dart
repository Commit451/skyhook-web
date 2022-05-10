import 'package:flutter/material.dart';
import 'package:skyhook/ui/skyhook_colors.dart';
import '../data/storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      primarySwatch: SkyhookColors.primaryMaterialColor(),
      appBarTheme: AppBarTheme(
        color: SkyhookColors.primaryColor(),
      ));

  final lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primarySwatch: SkyhookColors.primaryMaterialColor(),
  );

  late ThemeData _themeData;

  ThemeData getTheme() => _themeData;

  bool isDarkTheme() => _themeData == darkTheme;

  ThemeNotifier() {
    _themeData = darkTheme;
    StorageManager.isDarkTheme().then((isDarkTheme) {
      if (isDarkTheme) {
        _themeData = darkTheme;
      } else {
        _themeData = lightTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.setIsDarkTheme(true);
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.setIsDarkTheme(false);
    notifyListeners();
  }
}
