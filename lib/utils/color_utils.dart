import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dynamic_theme_data.dart';
import 'theme_utils.dart';

class ColorUtils {
  static List<Color> getThemeGradientColors(BuildContext context) {
    return Provider.of<DynamicThemeData>(context, listen: false).getGradientColors(ThemeUtils.isDarkMode(context));
  }

  static LinearGradient getThemeLinearGradient(BuildContext context) {
    return LinearGradient(colors: ColorUtils.getThemeGradientColors(context));
  }

  static Color getThemeOnGradientColor(BuildContext context) {
    return Provider.of<DynamicThemeData>(context, listen: false).getOnGradientColor(ThemeUtils.isDarkMode(context));
  }
}
