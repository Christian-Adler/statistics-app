import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/device_storage.dart';
import 'package:flutter_simple_logging/flutter_simple_logging.dart';

import '../models/i18n/app_language.dart';
import '../utils/device_storage_keys.dart';
import '../utils/global_settings.dart';

class AppLocale with ChangeNotifier {
  static const _keyAppLocale = 'appLocale';

  AppLanguage _appLanguage = AppLanguage.systemLanguage;

  AppLocale() {
    _init();
  }

  Locale? get locale {
    return _appLanguage.locale;
  }

  AppLanguage get appLanguage {
    return _appLanguage;
  }

  set appLanguage(AppLanguage? appLanguage) {
    if (appLanguage == null) return;
    _appLanguage = appLanguage;
    _store();
    notifyListeners();
  }

  Future<void> _store() async {
    try {
      final appLocaleData = {
        _keyAppLocale: _appLanguage.name,
      };
      await DeviceStorage.write(DeviceStorageKeys.keyAppLocale, jsonEncode(appLocaleData));
    } catch (err) {
      // await Dialogs.simpleOkDialog(err.toString(), context, title: 'Fehler');
      SimpleLogging.logger.w('Failed to store data.');
    }
  }

  Future<void> _init() async {
    final dataStr = await DeviceStorage.read(DeviceStorageKeys.keyAppLocale);
    if (dataStr != null) {
      final data = jsonDecode(dataStr) as Map<String, dynamic>;
      if (data.containsKey(_keyAppLocale)) {
        final languageName = data[_keyAppLocale] as String;
        _appLanguage = AppLanguage.languages().firstWhere((element) => element.name == languageName);
      }
    }

    GlobalSettings.onFirstDrawRelevantProviderInitialized();

    notifyListeners();
  }
}
