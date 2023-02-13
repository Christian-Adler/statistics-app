import 'package:flutter/material.dart';

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

  Future<void> logOut() async {
    _serverURL = null;
    _pw = null;
    notifyListeners();
  }
}
