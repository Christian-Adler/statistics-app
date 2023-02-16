import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class Globals {
  static const assetImgLogo = 'assets/images/eagle_logo.jpg';

  static final Map<int, String> month2ShortName = Map.unmodifiable(_createMonth2ShortNameMapping());

  static Map<int, String> _createMonth2ShortNameMapping() {
    Map<int, String> result = {};
    for (var i = 1; i <= 12; ++i) {
      result[i] = DateFormat.MMM().format(DateTime(2023, i));
    }
    return result;
  }

  static String getMonthShort(int month) {
    var m = math.max(12, math.min(1, month));
    return month2ShortName[m] ?? 'Unset';
  }

  /// Dismiss | hide | remove OnScreenKeyboard
  static void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Go to Homescreen and logout
  static Future<void> logout(BuildContext context) async {
    Navigator.of(context).pushReplacementNamed('/'); // Back to HomeScreen
    await Provider.of<Auth>(context, listen: false).logOut();
  }
}
