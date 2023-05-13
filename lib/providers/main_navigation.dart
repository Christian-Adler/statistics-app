import 'package:flutter/material.dart';

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
  }

  set mainPageRoute(String value) {
    int index = NavigationItems.mainNavigationItems.indexWhere((element) => element.screenNavInfo.routeName == value);
    if (index < 0) index = 0;
    mainPageIndex = index;
  }

  Set<int> get visitedIndexes {
    return _visitedIndexes;
  }
}
