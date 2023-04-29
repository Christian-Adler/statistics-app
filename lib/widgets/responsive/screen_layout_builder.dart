import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/providers/app_layout.dart';

import '../navigation/navigation_menu_vertical.dart';

class ScreenLayoutBuilder extends StatelessWidget {
  final Widget body; // auch als Builder mit parameter der Widgetgroesse + orientatin
  final Widget? drawer; // TODO builder weil muss ja nicht immer erzeugt werden - builder der Navigation- Liste liefert?
  // Der koennte Parameter erhlaten : orientation oder type
  final Widget? bottomNavigationBar;

  //TODO bottom tab bar - was mit zu vielen Nav Items? scrollbar... Menü?
  // TODO builder wie bei drawer
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  const ScreenLayoutBuilder(
      {Key? key, required this.body, this.drawer, this.bottomNavigationBar, this.appBar, this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final orientation = mediaQueryData.orientation;
    final isLandscape = orientation == Orientation.landscape;
    final isTablet = mediaQueryData.size.width > 750;
    // print(orientation);
    // print(mediaQueryData.size);
    // print(isTablet);

    final appLayout = Provider.of<AppLayout>(context);

    bool showNavigationTitle = appLayout.showNavigationItemTitle;

    Widget? drawerW;
    if (!isTablet) {
      drawerW = drawer;
    }

    Widget? bottomNavBarW;
    if (isTablet && !isLandscape) {
      bottomNavBarW = bottomNavigationBar;
    }

    Widget? bodyW;
    if (isLandscape && isTablet) {
      bodyW = Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0, 0.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            width: showNavigationTitle ? 304 : 56,
            child: NavigationMenuVertical(showNavigationTitle),
          ),
          Expanded(child: body),
        ],
      );
    }
    bodyW ??= body;

    return Scaffold(
      appBar: appBar,
      drawer: drawerW,
      bottomNavigationBar: bottomNavBarW,
      body: bodyW,
      floatingActionButton: floatingActionButton,
    );
  }
}
