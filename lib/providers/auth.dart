import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/device_storage.dart';

import '../utils/device_storage_keys.dart';
import '../utils/http_utils.dart';

class Auth with ChangeNotifier {
  String? _serverUrl;
  String? _pw;

  bool get isAuth {
    final serverUrl = _serverUrl;
    final pw = _pw;
    return serverUrl != null && serverUrl.isNotEmpty && pw != null && pw.isNotEmpty;
  }

  String get pw {
    return _pw ?? 'invalid';
  }

  String get serverUrl {
    return _serverUrl ?? 'invalid';
  }

  String get serverUrlWithoutProtocol {
    final serverUrl = _serverUrl;
    if (serverUrl != null) {
      return serverUrl.replaceFirst(RegExp(r'(\w+)://'), '');
    }
    return 'invalid';
  }

  Future<void> logIn(String serverUrl, String pw) async {
    final String? tmpServerUrl = _serverUrl;
    final String? tmpPw = _pw;
    _serverUrl = serverUrl;
    _pw = pw;

    try {
      await HttpUtils.sendRequest('connection_check', null, this);
      final authData = {'serverUrl': serverUrl, 'pw': _pw};
      final authDataStr = jsonEncode(authData);
      await DeviceStorage.write(DeviceStorageKeys.keyAuthData, authDataStr);

      List<String> servers = [];
      var strServers = await DeviceStorage.read(DeviceStorageKeys.keyServers);
      if (strServers != null) {
        servers.addAll((jsonDecode(strServers) as List<dynamic>).map((e) => e.toString()));
      }
      if (!servers.contains(serverUrl)) {
        servers.add(serverUrl);
        await DeviceStorage.write(DeviceStorageKeys.keyServers, jsonEncode(servers));
      }

      notifyListeners();
    } catch (e) {
      // reset
      _serverUrl = tmpServerUrl;
      _pw = tmpPw;
      notifyListeners();
      rethrow;
    }
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
