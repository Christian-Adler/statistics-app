import 'package:flutter/material.dart';

import '../providers/dynamic_theme_data.dart';

class ThemeUtils {
  static ThemeData buildThemeData(DynamicThemeData dynamicThemeData, BuildContext context) {
    final bool isDarkMode = dynamicThemeData.darkMode;

    var scaffoldBackgroundColor =
        isDarkMode ? const Color.fromRGBO(10, 10, 10, 1) : const Color.fromRGBO(245, 245, 245, 1);

    return ThemeData(
      primaryColor: dynamicThemeData.primaryColor,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: dynamicThemeData.primaryColor).copyWith(
        secondary: dynamicThemeData.secondaryColor,
        //   onPrimary: Colors.white, Farbe die auf primary verwendet wird.
        tertiary: dynamicThemeData.tertiaryColor,
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
            titleLarge: TextStyle(color: dynamicThemeData.primaryColor.shade700),
            titleSmall: TextStyle(color: dynamicThemeData.primaryColor.shade700),
          ),
      drawerTheme: Theme.of(context).drawerTheme.copyWith(backgroundColor: Colors.white),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
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
}
