import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:flutter_commons/widgets/double_back_to_close.dart';
import 'package:provider/provider.dart';

import '../../models/app_info.dart';
import '../../models/navigation/navigation_items.dart';
import '../../providers/app_layout.dart';
import '../../providers/main_navigation.dart';
import '../../utils/color_utils.dart';
import '../../utils/global_settings.dart';
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

  /// Prueft, ob auf Nested-Navigator-Pop und Overview.
  /// Wenn nein wird dort hin navigiert und BackToClose abgebrochen
  Future<bool> _checkForNestedNavigatorsAndOverviewBeforeClose(BuildContext context) async {
    final mainNavigation = Provider.of<MainNavigation>(context, listen: false);

    // Hat der aktive Screen einen "nested Navigator" ?
    // Dann versuchen auf diesem Pop aufrufen. Falls vom Stack gepoppt wurde, dann BackToClose abbrechen
    final navItem = NavigationItems.mainNavigationItems.elementAt(mainNavigation.mainPageIndex);
    final nestedNavigator = navItem.screenNavInfo.screensNestedNavigatorKey;
    if (nestedNavigator != null) {
      final popped = await nestedNavigator.currentState?.maybePop();
      if (popped != null && popped == true) {
        return true;
      }
    }

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

    Widget? bodyW;
    if (mediaQueryInfo.isLandscape && mediaQueryInfo.isTablet) {
      var appBar = AppBar(
        title: Text(AppInfo.appName),
        foregroundColor: ColorUtils.getThemeOnGradientColor(context),
        backgroundColor: ColorUtils.getThemeGradientColors(context).first,
      );
      GlobalSettings.appBarHeight = appBar.preferredSize.height;

      bodyW = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: showNavigationTitle ? 304 : 56,
            child: Scaffold(
              appBar: appBar,
              body: Drawer(
                child: NavigationMenuVertical(showNavigationTitle),
              ),
            ),
          ),
          Expanded(child: body),
        ],
      );
    }
    bodyW ??= body;

    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: bottomNavBarW,
      body: DoubleBackToClose(
        checkCallback: () => _checkForNestedNavigatorsAndOverviewBeforeClose(context),
        child: Container(
          decoration: BoxDecoration(gradient: ColorUtils.getThemeLinearGradient(context)),
          child: SafeArea(child: bodyW),
        ),
      ),
    );
  }
}
