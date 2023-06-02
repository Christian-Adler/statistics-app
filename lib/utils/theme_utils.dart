import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../providers/dynamic_theme_data.dart';

class ThemeUtils {
  static ThemeData buildThemeData(DynamicThemeData dynamicThemeData, BuildContext context, bool darkTheme) {
    final brightness = darkTheme ? Brightness.dark : Brightness.light;
    final scaffoldBackgroundColor =
        darkTheme ? const Color.fromRGBO(10, 10, 10, 1) : const Color.fromRGBO(245, 245, 245, 1);
    final drawerBackgroundColor = darkTheme ? const Color.fromRGBO(7, 7, 7, 1) : Colors.white;

    return ThemeData(
      brightness: brightness,
      primaryColor: darkTheme ? Colors.black : Colors.white,
      primaryColorLight: darkTheme ? Colors.white : Colors.black,
      primaryColorDark: darkTheme ? Colors.black : Colors.white,
      canvasColor: darkTheme ? Colors.black : Colors.white,
      indicatorColor: darkTheme ? Colors.white : Colors.black,
      appBarTheme:
          AppBarTheme(systemOverlayStyle: (darkTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light)),
      colorScheme: ColorScheme.fromSeed(seedColor: dynamicThemeData.primaryColor, brightness: brightness).copyWith(
        // primary: dynamicThemeData.primaryColor,
        // onPrimary: Colors.white, // Farbe die auf primary verwendet wird.
        secondary: dynamicThemeData.secondaryColor,
        tertiary: dynamicThemeData.tertiaryColor,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: dynamicThemeData.primaryColor.shade700),
        titleSmall: TextStyle(color: dynamicThemeData.primaryColor.shade700),
      ),
      drawerTheme: Theme.of(context).drawerTheme.copyWith(backgroundColor: drawerBackgroundColor),
      // dividerColor: dividerColor, // Trenner bei MenuItems-Gruppierung
      scaffoldBackgroundColor: scaffoldBackgroundColor /* otherwise white|black */,
      scrollbarTheme: Theme.of(context).scrollbarTheme.copyWith(
            thumbColor: MaterialStatePropertyAll(dynamicThemeData.primaryColor),
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
