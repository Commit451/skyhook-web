import 'package:flutter/material.dart';

class SnackBarHelper {
  static void show(BuildContext context, String content) {
    final snackBar = SnackBar(
      content: Text(content),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
