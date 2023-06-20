import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/hide_bottom_navigation_bar.dart';

import '../models/navigation/navigation_items.dart';

class MainNavigation with ChangeNotifier {
  int _mainPageIndex = 0;

  /// Welche Routen wurden schon geladen. Alle anderen werden als Placeholder erzeugt
  /// um nicht beim Start schon alle Screens (inklusive API Requests) zu erzeugen.
  final Set<int> _visitedIndexes = {0};

  int get mainPageIndex {
    return _mainPageIndex;
  }

  set mainPageIndex(int value) {
    _mainPageIndex = value;
    _visitedIndexes.add(value);
    notifyListeners();

    // OverViewSeite immer BottomBar anzeigen
    if (_mainPageIndex == 0) {
      HideBottomNavigationBar.setVisible(true);
    }
  }

  set mainPageRoute(String value) {
    int index = NavigationItems.mainNavigationItems.indexWhere((element) => element.screenNavInfo.routeName == value);
    if (index < 0) index = 0;
    mainPageIndex = index;
  }

  String get mainPageRoute {
    return NavigationItems.mainNavigationItems.elementAt(_mainPageIndex).screenNavInfo.routeName;
  }

  Set<int> get visitedIndexes {
    return _visitedIndexes;
  }
}
