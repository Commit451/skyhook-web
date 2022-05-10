import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyhook/ui/theme_notifier.dart';
import 'skyhook_app.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(),
    child: const SkyhookApp(),
  ));
}
