import 'package:flutter/material.dart';

import '../animation/no_transition_builder.dart';

class DynamicThemeData with ChangeNotifier {
  static const PageTransitionsTheme _noTransitions = PageTransitionsTheme(builders: {
    TargetPlatform.android: NoTransitionsBuilder(),
    TargetPlatform.iOS: NoTransitionsBuilder(),
  });

  PageTransitionsTheme? pageTransitionsTheme;

  set usePageTransition(bool value) {
    // Da dies ueber MediaQuery waehrend des Build gesetzt wird, darf im Fall einer Aenderung
    // das notifyListeners erst spaeter erfolgen!
    if (!value && pageTransitionsTheme == null) {
      pageTransitionsTheme = _noTransitions;
      doNotifyListenersPostFrame();
    } else if (value && pageTransitionsTheme != null) {
      pageTransitionsTheme = null;
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
