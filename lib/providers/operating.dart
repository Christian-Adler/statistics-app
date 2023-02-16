import 'package:flutter/foundation.dart';

import '../models/chart/year_month_chart_item.dart';
import 'auth.dart';

class Operating with ChangeNotifier {
  final Auth? auth;
  final List<YearMonthChartItem> _solarPowerItems;

  Operating(this.auth, this._solarPowerItems) {
    if (_solarPowerItems.isEmpty) {
      _solarPowerItems.addAll([
        YearMonthChartItem(2022, 7, 11),
        YearMonthChartItem(2022, 8, 3),
        YearMonthChartItem(2022, 9, 6),
        YearMonthChartItem(2022, 10, 12),
        YearMonthChartItem(2022, 11, 6),
        YearMonthChartItem(2022, 12, 6),
        YearMonthChartItem(2023, 1, 5)
      ]);
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

  ChartMetaData get solarPowerChartMetaData {
    if (_solarPowerItems.isEmpty) return ChartMetaData(0, 0, 1, 1);

    double yMin = double.maxFinite;
    double yMax = (double.maxFinite - 1) * -1;
    double xMin = double.maxFinite;
    double xMax = (double.maxFinite - 1) * -1;

    for (var item in _solarPowerItems) {
      var xVal = item.xValue;
      var yVal = item.value;
      if (xVal < xMin) xMin = xVal.toDouble();
      if (xVal > xMax) xMax = xVal.toDouble();
      if (yVal < yMin) yMin = yVal;
      if (yVal > yMax) yMax = yVal;
    }

    var xPadding = (xMax - xMin) / 20;
    var yPadding = (yMax - yMin) / 10;

    return ChartMetaData(xMin - xPadding, xMax + xPadding, yMin - yPadding, yMax + yPadding);
  }
}

class ChartMetaData {
  final double xMin;
  final double xMax;
  final double yMin;
  final double yMax;

  ChartMetaData(this.xMin, this.xMax, this.yMin, this.yMax);
}
