import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:flutter_commons/widgets/double_back_to_close.dart';
import 'package:provider/provider.dart';

import '../../models/app_info.dart';
import '../../providers/app_layout.dart';
import '../../providers/dynamic_theme_data.dart';
import '../../providers/main_navigation.dart';
import '../../utils/hide_bottom_navigation_bar.dart';
import '../navigation/navigation_menu_vertical.dart';

class AppLayoutBuilder extends StatelessWidget {
  final Widget body;

  // Builder-Funktion, damit nur erzeugt wird, falls auch benoetigt.
  final Widget Function()? bottomNavigationBarBuilder;

  const AppLayoutBuilder({
    Key? key,
    required this.body,
    this.bottomNavigationBarBuilder,
  }) : super(key: key);

  /// Prueft, ob auf Overview. Wenn nein wird dort hin navigiert und BackToClose abgebrochen
  bool _checkForOverviewBeforeClose(BuildContext context) {
    final mainNavigation = Provider.of<MainNavigation>(context, listen: false);
    if (mainNavigation.mainPageIndex != 0) {
      mainNavigation.mainPageIndex = 0;
      HideBottomNavigationBar.setVisible(true);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final appLayout = Provider.of<AppLayout>(context);
    bool showNavigationTitle = appLayout.showNavigationItemTitle;

    final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));

    Widget? bottomNavBarW;
    if (mediaQueryInfo.isPortrait) {
      final bottomNavigationBarBuilder = this.bottomNavigationBarBuilder;
      if (bottomNavigationBarBuilder != null) {
        bottomNavBarW = bottomNavigationBarBuilder();
      }
    }
    final dynamicThemeData = Provider.of<DynamicThemeData>(context, listen: false);
    dynamicThemeData.usePageTransition = !mediaQueryInfo.isTablet;

    Widget? bodyW;
    if (mediaQueryInfo.isLandscape && mediaQueryInfo.isTablet) {
      bodyW = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: showNavigationTitle ? 304 : 56,
            child: Scaffold(
              appBar: AppBar(
                title: Text(AppInfo.appName),
              ),
              body: Container(
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
                child: NavigationMenuVertical(showNavigationTitle),
              ),
            ),
          ),
          Expanded(child: body),
        ],
      );
    }
    bodyW ??= body;

    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: bottomNavBarW,
      body: DoubleBackToClose(
        checkCallback: () => _checkForOverviewBeforeClose(context),
        child: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: [colorScheme.primary, colorScheme.secondary])),
          child: SafeArea(child: bodyW),
        ),
      ),
    );
  }
}
