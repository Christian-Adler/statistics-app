import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';

class ScreenLayoutBuilder extends StatelessWidget {
  final Widget body;

  // Falls NestedNavigator erzeugt werden soll, dann mit GlobalKey, damit im WillPop zugegriffen werden kann
  final GlobalKey<NavigatorState>? createNestedNavigatorWithKey;

  // Builder-Funktion, damit nur erzeugt wird, falls auch benoetigt.
  final Widget Function(BuildContext context)? drawerBuilder;

// Builder-Funktion, damit der context (unterhalb des NestedNavigators) mitgegeben werden kann
  final PreferredSizeWidget Function(BuildContext context)? appBarBuilder;
  final Widget? floatingActionButton;

  const ScreenLayoutBuilder({
    Key? key,
    required this.body,
    this.drawerBuilder,
    this.appBarBuilder,
    this.floatingActionButton,
    this.createNestedNavigatorWithKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBarBuilder = this.appBarBuilder;

    final drawerBuilder = this.drawerBuilder;

    final createNestedNavigatorKey = createNestedNavigatorWithKey;
    if (createNestedNavigatorKey != null) {
      return Navigator(
        key: createNestedNavigatorKey,
        onGenerateRoute: (settings) {
          // print(settings.name);
          return MaterialPageRoute(builder: (ctx) {
            final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));
            final buildDrawer = (!mediaQueryInfo.isTablet && mediaQueryInfo.isLandscape && drawerBuilder != null);
            var appBar = appBarBuilder != null ? appBarBuilder(ctx) : null;
            return Scaffold(
              appBar: appBar,
              drawer: buildDrawer ? drawerBuilder(ctx) : null,
              body: body,
              floatingActionButton: floatingActionButton,
            );
          });
        },
      );
    }

    final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));
    final buildDrawer = (!mediaQueryInfo.isTablet && mediaQueryInfo.isLandscape && drawerBuilder != null);
    final appBar = appBarBuilder != null ? appBarBuilder(context) : null;
    return Scaffold(
      appBar: appBar,
      drawer: buildDrawer ? drawerBuilder(context) : null,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
