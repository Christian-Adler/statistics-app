import 'package:flutter/material.dart';
import 'package:flutter_commons/animation/transition/fade_transition_builder.dart';
import 'package:flutter_commons/animation/transition/no_transition_builder.dart';

class DynamicThemeData with ChangeNotifier {
  static const PageTransitionsTheme noTransitions = PageTransitionsTheme(builders: {
    TargetPlatform.android: NoTransitionsBuilder(),
    TargetPlatform.iOS: NoTransitionsBuilder(),
  });

  // horizontal sliding transitions for routes.
  static const PageTransitionsTheme hSlideTransitions = PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
  });

  // fade transitions for routes.
  static const PageTransitionsTheme fadeTransitions = PageTransitionsTheme(builders: {
    TargetPlatform.android: FadeTransitionsBuilder(),
    TargetPlatform.iOS: FadeTransitionsBuilder(),
  });

  PageTransitionsTheme? pageTransitionsTheme;

  set usePageTransition(bool value) {
    // Da dies ueber MediaQuery waehrend des Build gesetzt wird, darf im Fall einer Aenderung
    // das notifyListeners erst spaeter erfolgen!
    if (!value && pageTransitionsTheme == null) {
      pageTransitionsTheme = fadeTransitions;
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
