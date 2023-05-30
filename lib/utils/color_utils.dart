import 'package:flutter/material.dart';

class ColorUtils {
  static List<Color> getThemeGradientColors(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return [colorScheme.primary, colorScheme.tertiary, colorScheme.secondary];
  }

  static LinearGradient getThemeLinearGradient(BuildContext context) {
    return LinearGradient(colors: ColorUtils.getThemeGradientColors(context));
  }
}
