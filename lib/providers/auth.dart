import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:statistics/models/device_storage.dart';
import 'package:statistics/models/device_storage_keys.dart';

class Auth with ChangeNotifier {
  String? _serverUrl;
  String? _pw;

  bool get isAuth {
    return _serverUrl != null && _serverUrl!.isNotEmpty && _pw != null && _pw!.isNotEmpty;
  }

  String get pw {
    return _pw ?? 'invalid';
  }

  String get serverUrl {
    return _serverUrl ?? 'invalid';
  }

  Future<void> logIn(String serverUrl, String pw) async {
    // TODO try server connect
    _serverUrl = serverUrl;
    _pw = pw;
    notifyListeners();

    final authData = {'serverUrl': _serverUrl, 'pw': _pw};
    final authDataStr = jsonEncode(authData);
    await DeviceStorage.write(DeviceStorageKeys.keyAuthData, authDataStr);
  }

  Future<bool> tryAutoLogin() async {
    final authDataStr = await DeviceStorage.read(DeviceStorageKeys.keyAuthData);

    if (authDataStr == null) return false;

    final authData = jsonDecode(authDataStr) as Map<String, dynamic>;
    final s = authData['serverUrl'] as String;
    final p = authData['pw'] as String;

    if (s.isEmpty || p.isEmpty) return false;

    _serverUrl = s;
    _pw = p;

    notifyListeners(); // Darf nur bei true kommen! Sonst landet man immer im SplashScreen
    return true;
  }

  Future<void> logOut() async {
    _serverUrl = null;
    _pw = null;

    notifyListeners();

    await DeviceStorage.delete(DeviceStorageKeys.keyAuthData);
  }
}
