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
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
          primarySwatch: SkyhookColors.primaryMaterialColor(),
          appBarTheme: AppBarTheme(
            color: SkyhookColors.primaryColor(),
          )
      ),
      home: const SkyhookHomePage(title: 'skyhook'),
    );
  }
}
