import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/color_utils.dart';

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

  set primaryColor(MaterialColor color) {
    _primaryColor = color;
    notifyListeners();
  }

  setPurpleTheme() {
    _primaryColor = purpleThemePrimaryColor;
    _secondaryColor = purpleThemeSecondaryColor;
    _tertiaryColor = purpleThemeTertiaryColor;
    notifyListeners();
  }

  setBlueTheme() {
    _primaryColor = blueThemePrimaryColor;
    _secondaryColor = blueThemeSecondaryColor;
    _tertiaryColor = blueThemeTertiaryColor;
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

  set changeInBuildByMediaQuery(bool value) {
    // Da dies ueber MediaQuery waehrend des Build gesetzt wird, darf im Fall einer Aenderung
    // das notifyListeners erst spaeter erfolgen!
    if (!value /* && pageTransitionsTheme == null */) {
      doNotifyListenersPostFrame();
    } else if (value /* && pageTransitionsTheme != null */) {
      doNotifyListenersPostFrame();
    }
  }

  void doNotifyListenersPostFrame() {
    // https://stackoverflow.com/a/72657508
    // waere wohl auch moeglich:
    //  await Future.delayed(Duration(milliseconds: 1)); // use await
    //   notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
