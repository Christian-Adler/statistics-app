import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class Globals {
  static const assetImgEagleLogo = 'assets/images/eagle_logo.jpg';
  static const assetImgCaLogo = 'assets/images/ca_logo.jpg';
  static const assetImgExploratiaLogo = 'assets/images/exploratia_logo.jpg';
  static const assetImgBackground = 'assets/images/bar_chart.png';

  /// Go to Homescreen and logout
  static Future<void> logout(BuildContext context) async {
    goToHome(context); // Back to HomeScreen
    await Provider.of<Auth>(context, listen: false).logOut();
  }

  static void goToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
