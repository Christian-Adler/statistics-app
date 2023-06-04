import 'dart:math' as math;

import 'package:intl/intl.dart';

class DateUtil {
  static Map<int, String> _month2ShortName = _createMonth2ShortNameMapping();

  static Map<int, String> _createMonth2ShortNameMapping() {
    Map<int, String> result = {};
    for (var i = 1; i <= 12; ++i) {
      result[i] = DateFormat.MMM().format(DateTime(2023, i));
    }
    // 0 == 12 damit einfach % gerechnet werden kann
    result[0] = DateFormat.MMM().format(DateTime(2023, 12));
    return Map.unmodifiable(result);
  }

  /// Muss nach Sprachwechsel aufgerufen werden!
  static void init() {
    _month2ShortName = _createMonth2ShortNameMapping();
  }

  static String getMonthShort(int month) {
    var m = math.min(12, math.max(0, month));
    return _month2ShortName[m] ?? 'Unset';
  }

  static DateTime getInsertDate() {
    final now = DateTime.now();
    final thisOrLastMonth = now.day > 15 ? now : DateTime(now.year, now.month, -1);
    return thisOrLastMonth;
  }

  /// Prefix num with 0 if < 10
  static String num2Two(int num) {
    String res = num.toString();
    if (res.length < 2) {
      res = '0$res';
    }
    return res;
  }
}
