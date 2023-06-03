import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/color_utils.dart';
import 'package:flutter_commons/utils/device_storage.dart';

import '../utils/device_storage_keys.dart';

class _ThemeColors {
  final MaterialColor primary;
  final MaterialColor? onPrimary;
  final MaterialColor? secondary;
  final MaterialColor? tertiary;
  final List<Color> gradientColors;
  final Color onGradientColor;

  _ThemeColors({
    required this.primary,
    this.onPrimary,
    this.secondary,
    this.tertiary,
    required this.gradientColors,
    required this.onGradientColor,
  });

  _ThemeColors copyWidth({
    MaterialColor? primary,
    MaterialColor? onPrimary,
    MaterialColor? secondary,
    MaterialColor? tertiary,
    List<Color>? gradientColors,
    Color? onGradientColor,
  }) =>
      _ThemeColors(
        primary: primary ?? this.primary,
        onPrimary: onPrimary ?? this.onPrimary,
        secondary: secondary ?? this.secondary,
        tertiary: tertiary ?? this.tertiary,
        gradientColors: gradientColors ?? this.gradientColors,
        onGradientColor: onGradientColor ?? this.onGradientColor,
      );
}

class DynamicThemeData with ChangeNotifier {
  static final _purpleAmberColorsLight = _ThemeColors(
    primary: ColorUtils.customMaterialColor(Colors.purple.shade700),
    secondary: ColorUtils.customMaterialColor(Colors.amber),
    gradientColors: [Colors.purple, Colors.amber.shade800, Colors.amber],
    onGradientColor: Colors.white,
  );
  static final _purpleAmberColorsDark = _purpleAmberColorsLight.copyWidth(
      primary: ColorUtils.customMaterialColor(const Color.fromRGBO(255, 145, 0, 1.0)),
      gradientColors: [const Color(0xff4c1a57), Colors.amber.shade800, Colors.amber],
      onGradientColor: Colors.white);

  static final _blueGreenColorsLight = _ThemeColors(
    primary: ColorUtils.customMaterialColor(const Color(0xff00a8aa)),
    secondary: ColorUtils.customMaterialColor(const Color(0xffa6e300)),
    gradientColors: [const Color(0xff4c1a57), const Color(0xff00a8aa), const Color(0xffa6e300)],
    onGradientColor: Colors.white,
  );
  static final _blueGreenColorsDark = _blueGreenColorsLight.copyWidth();

  bool _useSystemThemeMode = true;
  bool _darkMode = false;

  bool _usePurpleColors = true;

  DynamicThemeData() {
    _init();
  }

  ThemeMode get themeMode {
    if (_useSystemThemeMode) return ThemeMode.system;
    return _darkMode ? ThemeMode.dark : ThemeMode.light;
  }

  bool get systemThemeMode {
    return _useSystemThemeMode;
  }

  set systemThemeMode(bool value) {
    final doUpdate = _useSystemThemeMode != value;
    if (doUpdate) {
      _useSystemThemeMode = value;
      _store();
      notifyListeners();
    }
  }

  /// Use darkMode getter/setter only in app theme settings card!<br><br>
  /// To test if Theme is dark mode (e.g. if SystemMode is set) use:
  /// <pre>final isDarkMode = Theme.of(context).brightness == Brightness.dark;</pre>
  bool get darkMode {
    return _darkMode;
  }

  set darkMode(bool value) {
    final doUpdate = _darkMode != value;
    if (doUpdate) {
      _darkMode = value;
      _store();
      notifyListeners();
    }
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

  _ThemeColors _getActiveThemeColors(bool darkMode) {
    if (_usePurpleColors) {
      return darkMode ? _purpleAmberColorsDark : _purpleAmberColorsLight;
    }
    return darkMode ? _blueGreenColorsDark : _blueGreenColorsLight;
  }

  MaterialColor getPrimaryColor(bool darkMode) {
    return _getActiveThemeColors(darkMode).primary;
  }

  Color getOnPrimaryColor(bool darkMode) {
    return _getActiveThemeColors(darkMode).onGradientColor;
  }

  MaterialColor? getSecondaryColor(bool darkMode) {
    return _getActiveThemeColors(darkMode).secondary;
  }

  MaterialColor? getTertiaryColor(bool darkMode) {
    return _getActiveThemeColors(darkMode).tertiary;
  }

  List<Color> getGradientColors(bool darkMode) {
    return _getActiveThemeColors(darkMode).gradientColors;
  }

  Color getOnGradientColor(bool darkMode) {
    return _getActiveThemeColors(darkMode).onGradientColor;
  }

  void _store() async {
    try {
      final appLayoutData = {
        'useSystemThemeMode': _useSystemThemeMode,
        'darkMode': _darkMode,
        'usePurpleColors': _usePurpleColors,
      };
      await DeviceStorage.write(DeviceStorageKeys.keyAppTheme, jsonEncode(appLayoutData));
    } catch (err) {
      // await Dialogs.simpleOkDialog(err.toString(), context, title: 'Fehler');
    }
  }

  void _init() async {
    final dataStr = await DeviceStorage.read(DeviceStorageKeys.keyAppTheme);
    if (dataStr == null) return;

    final data = jsonDecode(dataStr) as Map<String, dynamic>;
    if (data.containsKey('darkMode')) {
      _darkMode = data['darkMode'] as bool;
    }
    if (data.containsKey('useSystemThemeMode')) {
      _useSystemThemeMode = data['useSystemThemeMode'] as bool;
    }
    if (data.containsKey('usePurpleColors')) {
      _usePurpleColors = data['usePurpleColors'] as bool;
    }

    notifyListeners();
  }
}
