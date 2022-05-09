import 'package:flutter/material.dart';
import 'package:skyhook/skyhook_colors.dart';
import 'package:skyhook/skyhook_home_page.dart';

class SkyhookApp extends StatelessWidget {
  const SkyhookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'skyhook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: SkyhookColors.primaryMaterialColor(),
      ),
      themeMode: ThemeMode.dark,
      home: const SkyhookHomePage(title: 'skyhook'),
    );
  }
}