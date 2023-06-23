import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/color_utils.dart';
import 'package:flutter_commons/utils/device_storage.dart';

import '../utils/device_storage_keys.dart';
import '../utils/global_settings.dart';

class ThemeColors {
  final MaterialColor primary;
  final MaterialColor? onPrimary;
  final MaterialColor? secondary;
  final MaterialColor? tertiary;
  final List<Color> gradientColors;
  final Color onGradientColor;

  ThemeColors({
    required this.primary,
    this.onPrimary,
    this.secondary,
    this.tertiary,
    required this.gradientColors,
    required this.onGradientColor,
  });

  ThemeColors copyWidth({
    MaterialColor? primary,
    MaterialColor? onPrimary,
    MaterialColor? secondary,
    MaterialColor? tertiary,
    List<Color>? gradientColors,
    Color? onGradientColor,
  }) =>
      ThemeColors(
        primary: primary ?? this.primary,
        onPrimary: onPrimary ?? this.onPrimary,
        secondary: secondary ?? this.secondary,
        tertiary: tertiary ?? this.tertiary,
        gradientColors: gradientColors ?? this.gradientColors,
        onGradientColor: onGradientColor ?? this.onGradientColor,
      );
}

class _DefinedThemeColors {
  static final purpleAmberColorsLight = ThemeColors(
    primary: ColorUtils.customMaterialColor(Colors.purple.shade700),
    secondary: ColorUtils.customMaterialColor(Colors.amber),
    gradientColors: [Colors.purple, Colors.amber.shade800, Colors.amber],
    onGradientColor: Colors.white,
  );
  static final purpleAmberColorsDark = purpleAmberColorsLight.copyWidth(
      primary: ColorUtils.customMaterialColor(const Color.fromRGBO(255, 145, 0, 1.0)),
      gradientColors: [const Color(0xff4c1a57), Colors.amber.shade800, Colors.amber],
      onGradientColor: Colors.white);

  static final blueGreenColorsLight = ThemeColors(
    primary: ColorUtils.customMaterialColor(const Color(0xff00a8aa)),
    secondary: ColorUtils.customMaterialColor(const Color(0xffa6e300)),
    gradientColors: [const Color(0xff4c1a57), const Color(0xff00a8aa), const Color(0xffa6e300)],
    onGradientColor: Colors.white,
  );
  static final blueGreenColorsDark = blueGreenColorsLight.copyWidth();
}

class DynamicThemeData with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _darkMode = false;

  bool _usePurpleColors = true;

  DynamicThemeData() {
    _init();
  }

  ThemeMode get themeMode {
    return _themeMode;
  }

  set themeMode(ThemeMode? themeMode) {
    if (themeMode == null) return;
    _themeMode = themeMode;
    if (_themeMode == ThemeMode.dark) {
      _darkMode = true;
    } else if (_themeMode == ThemeMode.light) {
      _darkMode = false;
    }
    _store();
    notifyListeners();
  }

  bool get darkMode {
    return _darkMode;
  }

  set darkMode(bool darkMode) {
    if (_darkMode == darkMode) return;
    _darkMode = darkMode;
    notifyListeners();
  }

  bool get usePurpleTheme {
    return _usePurpleColors;
  }

  setPurpleTheme() {
    _usePurpleColors = true;
    _store();
    notifyListeners();
  }

  setBlueTheme() {
    _usePurpleColors = false;
    _store();
    notifyListeners();
  }

  ThemeColors getActiveThemeColors() {
    if (_usePurpleColors) {
      return _darkMode ? _DefinedThemeColors.purpleAmberColorsDark : _DefinedThemeColors.purpleAmberColorsLight;
    }
    return _darkMode ? _DefinedThemeColors.blueGreenColorsDark : _DefinedThemeColors.blueGreenColorsLight;
  }

  ThemeColors getThemeColors(bool darkMode) {
    if (_usePurpleColors) {
      return darkMode ? _DefinedThemeColors.purpleAmberColorsDark : _DefinedThemeColors.purpleAmberColorsLight;
    }
    return darkMode ? _DefinedThemeColors.blueGreenColorsDark : _DefinedThemeColors.blueGreenColorsLight;
  }

  MaterialColor getPrimaryColor() {
    return getActiveThemeColors().primary;
  }

  Color getOnPrimaryColor() {
    var activeThemeColors = getActiveThemeColors();
    return activeThemeColors.onPrimary ?? activeThemeColors.onGradientColor;
  }

  MaterialColor? getSecondaryColor() {
    return getActiveThemeColors().secondary;
  }

  MaterialColor? getTertiaryColor() {
    return getActiveThemeColors().tertiary;
  }

  List<Color> getGradientColors() {
    return getActiveThemeColors().gradientColors;
  }

  Color getOnGradientColor() {
    return getActiveThemeColors().onGradientColor;
  }

  void _store() async {
    try {
      final appLayoutData = {
        'themeMode': _themeMode.name,
        'usePurpleColors': _usePurpleColors,
      };
      await DeviceStorage.write(DeviceStorageKeys.keyAppTheme, jsonEncode(appLayoutData));
    } catch (err) {
      // await Dialogs.simpleOkDialog(err.toString(), context, title: 'Fehler');
    }
  }

  void _init() async {
    final dataStr = await DeviceStorage.read(DeviceStorageKeys.keyAppTheme);
    if (dataStr != null) {
      final data = jsonDecode(dataStr) as Map<String, dynamic>;
      if (data.containsKey('themeMode')) {
        final themeName = data['themeMode'] as String;
        if (themeName == ThemeMode.dark.name) {
          _themeMode = ThemeMode.dark;
        } else {
          _themeMode = themeName == ThemeMode.light.name ? ThemeMode.light : ThemeMode.system;
        }
      }
      if (data.containsKey('usePurpleColors')) {
        _usePurpleColors = data['usePurpleColors'] as bool;
      }
    }

    GlobalSettings.onFirstDrawRelevantProviderInitialized();

    notifyListeners();
  }
}
