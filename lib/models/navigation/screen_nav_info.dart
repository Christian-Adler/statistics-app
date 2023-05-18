import 'package:flutter/material.dart';

class ScreenNavInfo {
  final String title;
  final IconData iconData;
  final String routeName;

  final Widget Function() createScreen;

  final GlobalKey<NavigatorState>? screensNestedNavigatorKey;

  const ScreenNavInfo(this.title, this.iconData, this.routeName, this.createScreen, {this.screensNestedNavigatorKey});
}
