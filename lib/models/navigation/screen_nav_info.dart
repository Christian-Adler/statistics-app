import 'package:flutter/material.dart';

class ScreenNavInfo {
  final String Function(BuildContext) titleBuilder;
  final IconData iconData;
  final String routeName;

  final Widget Function() createScreen;

  final GlobalKey<NavigatorState>? screensNestedNavigatorKey;

  const ScreenNavInfo(this.titleBuilder, this.iconData, this.routeName, this.createScreen,
      {this.screensNestedNavigatorKey});
}
