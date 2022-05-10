import 'package:flutter/material.dart';

/// Colors used throughout the app
class SkyhookColors {
  static const _primary = 0xFF009688;
  static const _r = 0;
  static const _g = 150;
  static const _b = 136;

  static Color primaryColor() {
    return const Color(_primary);
  }

  static MaterialColor primaryMaterialColor() {
    Map<int, Color> color = {
      50: const Color.fromRGBO(_r, _g, _b, .1),
      100: const Color.fromRGBO(_r, _g, _b, .2),
      200: const Color.fromRGBO(_r, _g, _b, .3),
      300: const Color.fromRGBO(_r, _g, _b, .4),
      400: const Color.fromRGBO(_r, _g, _b, .5),
      500: const Color.fromRGBO(_r, _g, _b, .6),
      600: const Color.fromRGBO(_r, _g, _b, .7),
      700: const Color.fromRGBO(_r, _g, _b, .8),
      800: const Color.fromRGBO(_r, _g, _b, .9),
      900: const Color.fromRGBO(_r, _g, _b, 1),
    };
    return MaterialColor(_primary, color);
  }
}
