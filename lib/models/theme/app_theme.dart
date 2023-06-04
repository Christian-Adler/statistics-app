import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class AppTheme {
  final String name;
  final bool system;
  final bool dark;
  final String Function(BuildContext) getI18nName;

  AppTheme(this.name, this.system, this.dark, this.getI18nName);

  static final systemMode = AppTheme('System', true, false, (ctx) => S.of(ctx).settingsThemeModeSystem);
  static final lightMode = AppTheme('Light', false, false, (ctx) => S.of(ctx).settingsThemeModeLight);
  static final darkMode = AppTheme('Dark', false, true, (ctx) => S.of(ctx).settingsThemeModeDark);

  static final List<AppTheme> _knownModes = [];

  static void _checkInit() {
    if (_knownModes.isNotEmpty) return;
    _knownModes.addAll([
      AppTheme.systemMode,
      AppTheme.lightMode,
      AppTheme.darkMode,
    ]);
  }

  static List<AppTheme> modes() {
    _checkInit();
    return [..._knownModes];
  }

  @override
  bool operator ==(dynamic other) => other != null && other is AppTheme && name == other.name;

  @override
  int get hashCode => Object.hash(super.hashCode, name);
}
