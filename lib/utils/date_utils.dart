import 'dart:math' as math;

import 'package:intl/intl.dart';

class DateUtil {
  static final Map<int, String> month2ShortName = Map.unmodifiable(_createMonth2ShortNameMapping());

  static Map<int, String> _createMonth2ShortNameMapping() {
    Map<int, String> result = {};
    for (var i = 1; i <= 12; ++i) {
      result[i] = DateFormat.MMM().format(DateTime(2023, i));
    }
    // 0 == 12 damit einfach % gerechnet werden kann
    result[0] = DateFormat.MMM().format(DateTime(2023, 12));
    return result;
  }

  static String getMonthShort(int month) {
    var m = math.min(12, math.max(0, month));
    return month2ShortName[m] ?? 'Unset';
  }

  static DateTime getInsertDate() {
    final now = DateTime.now();
    final thisOrLastMonth = now.day > 15 ? now : DateTime(now.year, now.month, -1);
    return thisOrLastMonth;
  }
}
