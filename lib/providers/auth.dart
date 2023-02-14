import 'package:flutter/material.dart';
import 'package:statistics/models/device_storage.dart';

class Auth with ChangeNotifier {
  String? _serverURL;
  String? _pw;

  bool get isAuth {
    return _serverURL != null;
  }

  String get pw {
    return _pw ?? 'invalid';
  }

  String get serverUrl {
    return _serverURL ?? 'invalid';
  }

  Future<void> logIn(String serverUrl, String pw) async {
    // TODO try server connect
    _serverURL = serverUrl;
    _pw = pw;
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    var data = await DeviceStorage.readAll();
    print(data);

    // await DeviceStorage.write('test', 'TestValue');

    await Future.delayed(Duration.zero);
    return false;
    // final prefs = await SharedPreferences.getInstance();
    // if (!prefs.containsKey('userData')) return false;
    // final extractedUserData = jsonDecode(prefs.getString('userData')!) as Map<String, dynamic>;

    // _token = extractedUserData['token'];
    // _userId = extractedUserData['userId'];
    // notifyListeners(); // Darf nur bei true kommen! Sonst landet man immer im SplashScreen
    // return true;
  }

  Future<void> logOut() async {
    _serverURL = null;
    _pw = null;
    notifyListeners();
  }
}
