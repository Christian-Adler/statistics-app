import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:flutter_commons/widgets/double_back_to_close.dart';
import 'package:provider/provider.dart';

import '../../providers/app_layout.dart';
import '../../providers/dynamic_theme_data.dart';
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
              appBar: AppBar(),
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
        child: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: [colorScheme.primary, colorScheme.secondary])),
          child: SafeArea(child: bodyW),
        ),
      ),
    );
  }
}
