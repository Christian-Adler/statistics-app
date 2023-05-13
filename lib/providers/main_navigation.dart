import 'package:flutter/material.dart';
import 'package:statistics/models/navigation/navigation_items.dart';

class MainNavigation with ChangeNotifier {
  int _mainPageIndex = 0;

  int get mainPageIndex {
    return _mainPageIndex;
  }

  set mainPageIndex(int value) {
    _mainPageIndex = value;
    notifyListeners();
  }

  set mainPageRoute(String value) {
    int index = NavigationItems.mainNavigationItems.indexWhere((element) => element.screenNavInfo.routeName == value);
    if (index < 0) index = 0;
    _mainPageIndex = index;
    notifyListeners();
  }
}
