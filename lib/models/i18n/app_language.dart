import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class AppLanguage {
  final String name;
  final Locale? locale;
  final String Function(BuildContext) getI18nName;

  AppLanguage(this.name, this.locale, this.getI18nName);

  static final systemLanguage = AppLanguage('System', null, (ctx) => S.of(ctx).localeNameSystem);
  static final englishLanguage = AppLanguage('English', const Locale('en'), (ctx) => S.of(ctx).localeNameEnglish);

  static final List<AppLanguage> _knownLanguages = [];

  static void _checkInit() {
    if (_knownLanguages.isNotEmpty) return;
    _knownLanguages.addAll([
      AppLanguage.systemLanguage,
      AppLanguage.englishLanguage,
      AppLanguage('German', const Locale('de'), (ctx) => S.of(ctx).localeNameGerman),
    ]);
  }

  static List<AppLanguage> languages() {
    _checkInit();
    return [..._knownLanguages];
  }

  @override
  bool operator ==(dynamic other) => other != null && other is AppLanguage && name == other.name;

  @override
  int get hashCode => Object.hash(super.hashCode, name);
}
