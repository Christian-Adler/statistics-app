import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:provider/provider.dart';

import '../../providers/dynamic_theme_data.dart';

class ScreenLayoutBuilder extends StatelessWidget {
  final Widget body;

  // Builder-Funktion, damit nur erzeugt wird, falls auch benoetigt.
  final Widget Function()? drawerBuilder;

  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  const ScreenLayoutBuilder({Key? key, required this.body, this.drawerBuilder, this.appBar, this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));

    Widget? drawerW;
    final drawerBuilder = this.drawerBuilder;
    if (!mediaQueryInfo.isTablet && mediaQueryInfo.isLandscape && drawerBuilder != null) {
      drawerW = drawerBuilder();
    }

    final dynamicThemeData = Provider.of<DynamicThemeData>(context, listen: false);
    dynamicThemeData.usePageTransition = !mediaQueryInfo.isTablet;

    return Scaffold(
      appBar: appBar,
      drawer: drawerW,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
