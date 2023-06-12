import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../providers/dynamic_theme_data.dart';

class ThemeUtils {
  static ThemeData buildThemeData(DynamicThemeData dynamicThemeData, BuildContext context, bool dark) {
    final brightness = dark ? Brightness.dark : Brightness.light;
    final scaffoldBackgroundColor = dark ? const Color.fromRGBO(15, 15, 15, 1) : const Color.fromRGBO(240, 240, 240, 1);
    final drawerBackgroundColor = dark ? const Color.fromRGBO(7, 7, 7, 1) : Colors.white;

    return ThemeData(
      brightness: brightness,
      primaryColor: dark ? Colors.black : Colors.white,
      primaryColorLight: Colors.grey.shade200,
      primaryColorDark: Colors.grey.shade900,
      canvasColor: dark ? Colors.black : Colors.white,
      indicatorColor: dark ? Colors.white : Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: dynamicThemeData.getGradientColors(dark).first,
        foregroundColor: dynamicThemeData.getOnGradientColor(dark),
        actionsIconTheme: IconThemeData(color: dark ? Colors.black : Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle
            .light, // in all cases the background is dark -> light status bar (dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light),
      ),
      colorScheme:
          ColorScheme.fromSeed(seedColor: dynamicThemeData.getPrimaryColor(dark), brightness: brightness).copyWith(
        primary: dynamicThemeData.getPrimaryColor(dark),
        onPrimary: dynamicThemeData.getOnPrimaryColor(dark),
        secondary: dynamicThemeData.getSecondaryColor(dark),
        tertiary: dynamicThemeData.getTertiaryColor(dark),
      ),
      textTheme: const TextTheme(
          // titleLarge: TextStyle(color: dynamicThemeData.getPrimaryColor(dark)),
          // titleMedium: TextStyle(fontWeight: FontWeight.bold),
          // titleSmall: TextStyle(color: dynamicThemeData.getPrimaryColor(dark)),
          ),
      drawerTheme: Theme.of(context).drawerTheme.copyWith(backgroundColor: drawerBackgroundColor),
      // dividerColor: dividerColor, // Trenner bei MenuItems-Gruppierung
      scaffoldBackgroundColor: scaffoldBackgroundColor /* otherwise white|black */,

      scrollbarTheme: Theme.of(context).scrollbarTheme.copyWith(
            thumbColor: MaterialStatePropertyAll(dynamicThemeData.getPrimaryColor(dark)),
            radius: Radius.zero,
            interactive: true,
            // thickness: const MaterialStatePropertyAll(10),
            // thumbVisibility: const MaterialStatePropertyAll(true),
            // trackVisibility: const MaterialStatePropertyAll(true),
            // trackColor: const MaterialStatePropertyAll(Colors.blueAccent),
            // trackBorderColor: const MaterialStatePropertyAll(Colors.purpleAccent),
          ),
    );
  }

  /// returns if Theme is dark (by colorScheme brightness)
  static bool isDarkMode(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode;
  }
}
