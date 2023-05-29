import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/device_storage.dart';

import '../utils/device_storage_keys.dart';

class AppLayout with ChangeNotifier {
  bool _showNavigationItemTitle = true;
  bool _enableOverviewParallax = true;

  AppLayout() {
    _init();
  }

  bool get showNavigationItemTitle {
    return _showNavigationItemTitle;
  }

  set showNavigationItemTitle(bool value) {
    _showNavigationItemTitle = value;
    _store();
    notifyListeners();
  }

  bool get enableOverviewParallax {
    return _enableOverviewParallax;
  }

  set enableOverviewParallax(bool value) {
    _enableOverviewParallax = value;
    _store();
    notifyListeners();
  }

  void _store() async {
    try {
      final appLayoutData = {
        'showNavigationItemTitle': _showNavigationItemTitle,
        'enableOverviewParallax': _enableOverviewParallax,
      };
      await DeviceStorage.write(DeviceStorageKeys.keyAppLayout, jsonEncode(appLayoutData));
    } catch (err) {
      // await Dialogs.simpleOkDialog(err.toString(), context, title: 'Fehler');
    }
  }

  void _init() async {
    final dataStr = await DeviceStorage.read(DeviceStorageKeys.keyAppLayout);
    if (dataStr == null) return;

    final data = jsonDecode(dataStr) as Map<String, dynamic>;
    if (data.containsKey('showNavigationItemTitle')) {
      _showNavigationItemTitle = data['showNavigationItemTitle'] as bool;
    }
    if (data.containsKey('enableOverviewParallax')) {
      _enableOverviewParallax = data['enableOverviewParallax'] as bool;
    }

    notifyListeners();
  }
}
