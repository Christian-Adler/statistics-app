import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class Globals {
  static const assetImgLogo = 'assets/images/eagle_logo.jpg';

  /// Dismiss | hide | remove OnScreenKeyboard
  static void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Go to Homescreen and logout
  static Future<void> logout(BuildContext context) async {
    goToHome(context); // Back to HomeScreen
    await Provider.of<Auth>(context, listen: false).logOut();
  }

  static void goToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
