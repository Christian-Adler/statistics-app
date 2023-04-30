import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:provider/provider.dart';
import 'package:statistics/providers/dynamic_theme_data.dart';

import '../../providers/app_layout.dart';
import '../navigation/navigation_menu_vertical.dart';

class ScreenLayoutBuilder extends StatelessWidget {
  final Widget body;

  // Fuer AppDrawer und BottomNavigationBar jeweils Builder-Funktion, damit nur erzeugt wird, falls auch benoetigt.
  final Widget Function()? drawerBuilder;
  final Widget Function()? bottomNavigationBarBuilder;

  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  const ScreenLayoutBuilder(
      {Key? key,
      required this.body,
      this.drawerBuilder,
      this.bottomNavigationBarBuilder,
      this.appBar,
      this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLayout = Provider.of<AppLayout>(context);
    bool showNavigationTitle = appLayout.showNavigationItemTitle;

    final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));

    Widget? drawerW;
    final drawerBuilder = this.drawerBuilder;
    if (!mediaQueryInfo.isTablet && drawerBuilder != null) {
      drawerW = drawerBuilder();
    }

    Widget? bottomNavBarW;
    if (mediaQueryInfo.isTablet && !mediaQueryInfo.isLandscape) {
      final bottomNavigationBarBuilder = this.bottomNavigationBarBuilder;
      if (bottomNavigationBarBuilder != null) {
        bottomNavBarW = bottomNavigationBarBuilder();
      }
    }
    final dynamicThemeData = Provider.of<DynamicThemeData>(context, listen: false);
    dynamicThemeData.usePageTransition = bottomNavBarW == null;

    Widget? bodyW;
    if (mediaQueryInfo.isLandscape && mediaQueryInfo.isTablet) {
      bodyW = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
