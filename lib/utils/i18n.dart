import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class I18N {
  /// Shortcut for no need to import flutter_gen always manually
  /// usage: I18N.of(context).helloWorld
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}
