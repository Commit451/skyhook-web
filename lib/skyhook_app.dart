import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyhook/skyhook_home_page.dart';
import 'package:skyhook/ui/theme_notifier.dart';

class SkyhookApp extends StatelessWidget {
  const SkyhookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, _) => MaterialApp(
              title: 'skyhook',
              debugShowCheckedModeBanner: false,
              theme: themeNotifier.getTheme(),
              home: const SkyhookHomePage(title: 'skyhook'),
            ));
  }
}
