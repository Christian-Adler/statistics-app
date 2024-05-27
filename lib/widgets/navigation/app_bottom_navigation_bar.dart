import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/hide_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../models/navigation/navigation_item.dart';
import '../../models/navigation/navigation_items.dart';
import '../../providers/app_layout.dart';
import '../../providers/main_navigation.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  List<BottomNavigationBarItem> _buildNavItems(BuildContext context) {
    List<BottomNavigationBarItem> result = [];
    for (var navItem in NavigationItems.navigationBarItems) {
      result.add(BottomNavigationBarItem(
        icon: Icon(navItem.iconData),
        label: navItem.getTitle(context),
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

  Future<void> _onItemTapped(
      int index, BuildContext context, bool showNavigationTitle) async {
    if (index < NavigationItems.navigationBarItems.length) {
      var navigationItem = NavigationItems.navigationBarItems.elementAt(index);
      navigationItem.onNav(context);
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
              title: showNavigationTitle
                  ? Text(navItem.getTitle(context))
                  : Icon(navItem.iconData),
              leading: showNavigationTitle ? Icon(navItem.iconData) : null,
              // onTap: () { // dann geht das Menu nicht zu... :/
              //   navItem.onNav(context, navigator);
              // },
            )));
      } else if (navItem.isDividerSmall || navItem.isDividerLarge) {
        items.add(const PopupMenuDivider());
      }
    }

    var renderBox = context.findRenderObject() as RenderBox;
    // final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    var res = await showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(1, offset.dy, 0, 0),
      items: items,
      elevation: 8.0,
    );

    if (res != null && context.mounted) {
      var navItem = NavigationItems.navigationBarMenuItems.elementAt(res);
      if (navItem.isNavigation && navItem is NavigationItem) {
        navItem.onNav(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLayout = Provider.of<AppLayout>(context);
    bool showNavigationTitle =
        Platform.isIOS || appLayout.showNavigationItemTitle;

    int selectedIdx = Provider.of<MainNavigation>(context).mainPageIndex;

    if (selectedIdx >= NavigationItems.navigationBarItems.length) {
      // Extra Menu?
      if (NavigationItems.navigationBarMenuItems.isNotEmpty) {
        selectedIdx = NavigationItems.navigationBarItems.length;
      } else {
        selectedIdx = 0; // Fallback Uebersicht
      }
    }

    final themeData = Theme.of(context);
    final selectedItemColor = themeData.colorScheme.primary;
    final unselectedItemColor = themeData.indicatorColor;
    return ValueListenableBuilder(
      valueListenable: HideBottomNavigationBar.visible,
      builder: (ctx, value, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: value ? 58 : 0,
          child: OverflowBox(
            alignment: AlignmentDirectional.topCenter,
            maxHeight: 58,
            minHeight: 0,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: _buildNavItems(ctx),
              currentIndex: selectedIdx,
              selectedItemColor: selectedItemColor,
              unselectedItemColor: unselectedItemColor,
              showSelectedLabels: showNavigationTitle,
              showUnselectedLabels: showNavigationTitle,
              onTap: (idx) => _onItemTapped(idx, ctx, showNavigationTitle),
            ),
          ),
        );
      },
    );
  }
}
