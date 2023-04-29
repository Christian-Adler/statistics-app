import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/navigation/navigation_item.dart';
import '../../models/navigation/navigation_items.dart';
import '../../providers/app_layout.dart';
import '../../utils/nav/navigation_utils.dart';

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

    // Extra-Menu-Punkte?
    if (NavigationItems.navigationBarMenuItems.isNotEmpty) {
      result.add(const BottomNavigationBarItem(
        icon: Icon(Icons.menu),
        label: 'Menu',
      ));
    }

    return result;
  }

  void _onItemTapped(int index, BuildContext context, NavigatorState navigator, bool showNavigationTitle) async {
    if (index < NavigationItems.navigationBarItems.length) {
      var navigationItem = NavigationItems.navigationBarItems.elementAt(index);
      navigationItem.onNav(context, navigator);
      return;
    }

    // Menu geklickt...
    List<PopupMenuEntry<int>> items = [];
    for (var i = 0; i < NavigationItems.navigationBarMenuItems.length; ++i) {
      var navItem = NavigationItems.navigationBarMenuItems[i];
      if (navItem.isNavigation && navItem is NavigationItem) {
        items.add(PopupMenuItem<int>(
            value: i,
            child: ListTile(
              title: showNavigationTitle ? Text(navItem.title) : Icon(navItem.iconData),
              leading: showNavigationTitle ? Icon(navItem.iconData) : null,
              // onTap: () { // dann geht das Menu nicht zu... :/
              //   navItem.onNav(context, navigator);
              // },
            )));
      } else if (navItem.isDividerSmall || navItem.isDividerLarge) {
        items.add(const PopupMenuDivider());
      }
    }

    var res = await showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(1000.0, 2000.0, 0.0, 0.0),
      items: items,
      elevation: 8.0,
    );

    if (res != null && context.mounted) {
      var navItem = NavigationItems.navigationBarMenuItems.elementAt(res);
      if (navItem.isNavigation && navItem is NavigationItem) {
        navItem.onNav(context, navigator);
      }
    }
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
      type: BottomNavigationBarType.fixed,
      items: _buildNavItems(context),
      currentIndex: selectedIdx,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.black54,
      showSelectedLabels: showNavigationTitle,
      showUnselectedLabels: showNavigationTitle,
      onTap: (idx) => _onItemTapped(idx, context, navigator, showNavigationTitle),
    );
  }
}
