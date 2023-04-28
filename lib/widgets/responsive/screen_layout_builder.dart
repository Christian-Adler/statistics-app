import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/providers/app_layout.dart';

import '../navigation/navigation_menu_vertical.dart';

class ScreenLayoutBuilder extends StatelessWidget {
  final Widget body; // auch als Builder mit parameter der Widgetgroesse + orientatin
  final Widget drawer; // TODO builder weil muss ja nicht immer erzeugt werden - builder der Navigation- Liste liefert?
  // Der koennte Parameter erhlaten : orientation oder type
  // Small Drawer ? Also nur Icons?
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  const ScreenLayoutBuilder(
      {Key? key, required this.body, required this.drawer, this.appBar, this.floatingActionButton})
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

    bool showNavigationTitle = appLayout.isShowNavigationItemTitle;

    Widget? drawerW;
    if (!isLandscape || !isTablet) {
      drawerW = drawer;
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
            width: showNavigationTitle ? 300 : 60,
            child: NavigationMenuVertical(showNavigationTitle: showNavigationTitle),
          ),
          Expanded(child: body),
        ],
      );
    }
    bodyW ??= body;

    // TODO ScreenSize
    // TODO SplitView davon abhaenigi
    return Scaffold(
      appBar: appBar,
      drawer: drawerW,
      body: bodyW,
      floatingActionButton: floatingActionButton,
    );
  }
}
