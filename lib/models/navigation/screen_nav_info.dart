import 'package:flutter/material.dart';

class ScreenNavInfo {
  final String Function(BuildContext) titleBuilder;
  final IconData iconData;
  final String routeName;

  final Widget Function() createScreen;

  final GlobalKey<NavigatorState>? screensNestedNavigatorKey;

  /// Normalerweise werden Screens beim Wechsel nicht aus dem WidgetTree entfernt, damit sie ihren State (z.B. nestedNavigator) erhalten.
  /// Wenn aber ein Screen jedes Mal wenn er angewaehlt wird neu geladen werden soll, dann flag auf true setzen.
  final bool disposeIfNotVisible;

  const ScreenNavInfo(
    this.titleBuilder,
    this.iconData,
    this.routeName,
    this.createScreen, {
    this.screensNestedNavigatorKey,
    this.disposeIfNotVisible = false,
  });
}
