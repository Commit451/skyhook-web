import 'package:flutter/material.dart';
import 'package:skyhook/skyhook_colors.dart';

/// Standard loading widgets
class LoadingWidgetFactory {
  static CircularProgressIndicator indicator() {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(SkyhookColors.primaryColor()),
    );
  }

  static Widget centeredIndicator() {
    return Center(
      child: indicator(),
    );
  }
}
