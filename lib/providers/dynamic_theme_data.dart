import 'package:flutter/material.dart';

class DynamicThemeData with ChangeNotifier {
  MaterialColor _primaryColor = Colors.blue; // Colors.purple;

//   final dynamicThemeData = Provider.of<DynamicThemeData>(context, listen: false);

  set primaryColor(MaterialColor color) {
    _primaryColor = color;
    notifyListeners();
  }

  MaterialColor get primaryColor {
    return _primaryColor;
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
