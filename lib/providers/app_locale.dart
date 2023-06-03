import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/device_storage.dart';

import '../models/i18n/app_language.dart';
import '../utils/device_storage_keys.dart';

class AppLocale with ChangeNotifier {
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

  void _store() async {
    try {
      final appLocaleData = {
        'appLocale': _appLanguage.name,
      };
      await DeviceStorage.write(DeviceStorageKeys.keyAppLocale, jsonEncode(appLocaleData));
    } catch (err) {
      // await Dialogs.simpleOkDialog(err.toString(), context, title: 'Fehler');
    }
  }

  void _init() async {
    final dataStr = await DeviceStorage.read(DeviceStorageKeys.keyAppLocale);
    if (dataStr == null) return;

    final data = jsonDecode(dataStr) as Map<String, dynamic>;
    if (data.containsKey('appLocale')) {
      final languageName = data['appLocale'] as String;
      _appLanguage = AppLanguage.languages().firstWhere((element) => element.name == languageName);
    }

    notifyListeners();
  }
}
