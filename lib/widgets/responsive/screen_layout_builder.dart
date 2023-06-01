import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';

class ScreenLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) bodyBuilder;

  // Falls NestedNavigator erzeugt werden soll, dann mit GlobalKey, damit im WillPop zugegriffen werden kann
  final GlobalKey<NavigatorState>? createNestedNavigatorWithKey;

  // Builder-Funktion, damit nur erzeugt wird, falls auch benoetigt.
  final Widget Function(BuildContext context)? drawerBuilder;

  // Builder-Funktion, damit der context (unterhalb des NestedNavigators) mitgegeben werden kann
  final PreferredSizeWidget Function(BuildContext context)? appBarBuilder;
  final Widget Function(BuildContext context)? floatingActionButtonBuilder;

  const ScreenLayoutBuilder({
    Key? key,
    required this.bodyBuilder,
    this.drawerBuilder,
    this.appBarBuilder,
    this.floatingActionButtonBuilder,
    this.createNestedNavigatorWithKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final createNestedNavigatorWithKey = this.createNestedNavigatorWithKey;
    if (createNestedNavigatorWithKey != null) {
      return Navigator(
        key: createNestedNavigatorWithKey,
        onGenerateRoute: (settings) {
          // print(settings.name);
          return MaterialPageRoute(builder: (ctx) {
            return _buildScaffold(ctx);
          });
        },
      );
    }

    return _buildScaffold(context);
  }

  Widget _buildScaffold(BuildContext context) {
    final appBarBuilder = this.appBarBuilder;
    final floatingActionButtonBuilder = this.floatingActionButtonBuilder;
    final drawerBuilder = this.drawerBuilder;

    final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));
    final buildDrawer = (!mediaQueryInfo.isTablet && mediaQueryInfo.isLandscape && drawerBuilder != null);
    final appBar = appBarBuilder != null ? appBarBuilder(context) : null;
    final floatingActionButton = floatingActionButtonBuilder != null ? floatingActionButtonBuilder(context) : null;
    return Scaffold(
      appBar: appBar,
      drawer: buildDrawer ? drawerBuilder(context) : null,
      body: bodyBuilder(context),
      floatingActionButton: floatingActionButton,
    );
  }
}
