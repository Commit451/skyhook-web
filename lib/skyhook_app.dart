import 'package:flutter/material.dart';
import 'package:skyhook/skyhook_home_page.dart';
import 'package:skyhook/ui/skyhook_colors.dart';

class SkyhookApp extends StatelessWidget {
  const SkyhookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDPilates',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: SkyhookColors.primaryColor(),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SkyhookHomePage(title: 'skyhook'),
    );
  }
}
