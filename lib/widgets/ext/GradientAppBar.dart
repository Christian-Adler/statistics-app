import 'package:flutter/material.dart';

class GradientAppBar extends AppBar {
  GradientAppBar({super.key, required Widget title, required List<Color> gradientColors, List<Widget>? actions})
      : super(
            title: title,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColors),
              ),
            ),
            actions: actions);
}
