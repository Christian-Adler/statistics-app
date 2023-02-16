import 'package:flutter/foundation.dart';

import '../models/chart/year_month_chart_item.dart';
import 'auth.dart';

class Operating with ChangeNotifier {
  final Auth? auth;
  final List<YearMonthChartItem> _solarPowerItems;

  Operating(this.auth, this._solarPowerItems) {
    if (_solarPowerItems.isEmpty) {
      _solarPowerItems.addAll([YearMonthChartItem(2022, 12, 6), YearMonthChartItem(2023, 1, 5)]);
      // TODO dummy daten wieder entfernen
    }
  }

  List<YearMonthChartItem> get solarPowerItems {
    return [..._solarPowerItems];
  }

  Future<void> addSolarPowerEntry(double value) async {
    final now = DateTime.now();
    final powerChartItem = YearMonthChartItem(now.year, now.month, value);
    _solarPowerItems.add(powerChartItem);
    notifyListeners();
  }
}
