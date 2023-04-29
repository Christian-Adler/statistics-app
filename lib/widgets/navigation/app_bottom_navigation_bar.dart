import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/utils/nav/navigation_utils.dart';

import '../../models/navigation/navigation_items.dart';
import '../../providers/app_layout.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  List<BottomNavigationBarItem> _buildNavItems(BuildContext context) {
    List<BottomNavigationBarItem> result = [];
    for (var navItem in NavigationItems.navigationBarItems) {
      result.add(BottomNavigationBarItem(
        icon: Icon(navItem.iconData),
        label: navItem.title,
      ));
    }

    // TODO openBottomDrawer https://ptyagicodecamp.github.io/bottomnavigationbar-with-menu-search-and-overflow-action-items.html

    return result;
  }

  void _onItemTapped(int index, BuildContext context, NavigatorState navigator) {
    var navigationItem = NavigationItems.navigationBarItems.elementAt(index);
    navigationItem.onNav(context, navigator);
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final appLayout = Provider.of<AppLayout>(context);
    bool showNavigationTitle = Platform.isIOS || appLayout.showNavigationItemTitle;

    var actRouteName = NavigationUtils.getActRouteSettings(context)?.name ?? '/';
    // print(actRouteName);
    int selectedIdx = -1;
    if (actRouteName == '/') {
      selectedIdx = 0;
    } else {
      for (var i = 0; i < NavigationItems.navigationBarItems.length; ++i) {
        var navItem = NavigationItems.navigationBarItems[i];
        if (navItem.screenNavInfo.routeName.contains(actRouteName)) {
          selectedIdx = i;
          break;
        }
      }
    }

    return BottomNavigationBar(
      items: _buildNavItems(context),
      currentIndex: selectedIdx,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.black54,
      showSelectedLabels: showNavigationTitle,
      showUnselectedLabels: showNavigationTitle,
      onTap: (idx) => _onItemTapped(idx, context, navigator),
    );
  }
}
