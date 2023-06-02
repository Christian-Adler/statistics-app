import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/color_utils.dart';
import 'package:flutter_commons/utils/device_storage.dart';

import '../utils/device_storage_keys.dart';

class DynamicThemeData with ChangeNotifier {
  static final MaterialColor purpleThemePrimaryColor = ColorUtils.customMaterialColor(Colors.purple);
  static final MaterialColor purpleThemeSecondaryColor = ColorUtils.customMaterialColor(Colors.amber);
  static final MaterialColor purpleThemeTertiaryColor = ColorUtils.customMaterialColor(Colors.amber.shade800);
  static final MaterialColor blueThemePrimaryColor = ColorUtils.customMaterialColor(const Color(0xff4c1a57));
  static final MaterialColor blueThemeSecondaryColor = ColorUtils.customMaterialColor(const Color(0xffa6e300));
  static final MaterialColor blueThemeTertiaryColor = ColorUtils.customMaterialColor(const Color(0xff00a8aa));
  MaterialColor _primaryColor = purpleThemePrimaryColor;
  MaterialColor _secondaryColor = purpleThemeSecondaryColor;
  MaterialColor _tertiaryColor = purpleThemeTertiaryColor;

  bool _darkMode = false;

  DynamicThemeData() {
    _init();
  }

  ThemeMode get themeMode {
    return _darkMode ? ThemeMode.dark : ThemeMode.light;
  }

  bool get darkMode {
    return _darkMode;
  }

  set darkMode(bool value) {
    _darkMode = value;
    _store();
    notifyListeners();
  }

  set primaryColor(MaterialColor color) {
    _primaryColor = color;
    _store();
    notifyListeners();
  }

  setPurpleTheme() {
    _primaryColor = purpleThemePrimaryColor;
    _secondaryColor = purpleThemeSecondaryColor;
    _tertiaryColor = purpleThemeTertiaryColor;
    _store();
    notifyListeners();
  }

  setBlueTheme() {
    _primaryColor = blueThemePrimaryColor;
    _secondaryColor = blueThemeSecondaryColor;
    _tertiaryColor = blueThemeTertiaryColor;
    _store();
    notifyListeners();
  }

  MaterialColor get primaryColor {
    return _primaryColor;
  }

  MaterialColor get secondaryColor {
    return _secondaryColor;
  }

  MaterialColor get tertiaryColor {
    return _tertiaryColor;
  }

  void _store() async {
    try {
      final appLayoutData = {
        'darkMode': _darkMode,
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

    notifyListeners();
  }
}
