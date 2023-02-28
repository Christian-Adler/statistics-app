import 'package:flutter/foundation.dart';
import 'package:statistics/utils/date_utils.dart';

import '../models/chart/operating_chart_item.dart';
import '../utils/http_utils.dart';
import 'auth.dart';

class Operating with ChangeNotifier {
  final Auth? auth;
  final List<OperatingChartItem> _operatingItems;
  final List<OperatingChartItem> _operatingItemsYearly;

  static double chargePerMonthWater = 1;
  static double chargePerValueWater = 1;
  static double chargePerMonthConsumedPower = 1;
  static double chargePerValueConsumedPower = 1;
  static double chargePerMonthHeating = 1;
  static double chargePerValueHeating = 1;

  Operating(this.auth, this._operatingItems, this._operatingItemsYearly);

  Future<void> fetchDataIfNotYetLoaded() async {
    if (_operatingItems.isEmpty) {
      await sendAndFetchData_(null);
      notifyListeners();
    }
  }

  Future<void> fetchData() async {
    await sendAndFetchData_(null);
    notifyListeners();
  }

  Future<void> sendAndFetchData_(Map<String, String>? params) async {
    if (auth == null) return;

    final result = await HttpUtils.sendRequest('haus_nebenkosten', params, auth!);

    // Monatswerte
    var charges = result['charge'] as Map<String, dynamic>;
    chargePerMonthWater = (charges['water_charge_per_month'] as num).toDouble();
    chargePerValueWater = (charges['water_charge_per_qm'] as num).toDouble();
    chargePerMonthConsumedPower = (charges['electricity_charge_per_month'] as num).toDouble();
    chargePerValueConsumedPower = (charges['electricity_charge_per_kwh'] as num).toDouble();
    chargePerMonthHeating = (charges['heating_charge_per_month'] as num).toDouble();
    chargePerValueHeating = (charges['heating_charge_per_kwh'] as num).toDouble();

    final dataList = result['data'] as List<dynamic>;
    _operatingItems.clear();
    _operatingItemsYearly.clear();

    int actYear = -1;
    double sumWater = 0;
    double sumGeneratedPower = 0;
    double sumFeedPower = 0;
    double sumConsumedPower = 0;
    double sumHeating = 0;

    for (var item in dataList) {
      final map = item as Map<String, dynamic>;

      final year = (map['jahr'] as int);
      var month = (map['monat'] as int);
      var generatedPower = (map['strom_solar'] as int).toDouble();
      var consumedPower = (map['strom'] as int).toDouble();
      var feedPower = (map['strom_einspeisung'] as int).toDouble();
      var water = (map['wasser'] as int).toDouble();
      var heating = (map['heizung'] as int).toDouble();

      _operatingItems.add(OperatingChartItem(
        year,
        month,
        generatedPower,
        consumedPower,
        feedPower,
        water,
        heating,
      ));

      if (year != actYear) {
        if (actYear > -1 && actYear != 2015) {
          // 2015 war ja nur das Ende - macht das Chart unuebersichtlich
          _operatingItemsYearly.add(OperatingChartItem(
            actYear,
            0,
            sumGeneratedPower,
            sumConsumedPower,
            sumFeedPower,
            sumWater,
            sumHeating,
          ));
        }
        actYear = year;
        sumWater = 0;
        sumGeneratedPower = 0;
        sumFeedPower = 0;
        sumConsumedPower = 0;
        sumHeating = 0;
      }

      sumWater += water;
      sumGeneratedPower += generatedPower;
      sumFeedPower += feedPower;
      sumConsumedPower += consumedPower;
      sumHeating += heating;
    }

    if (actYear > -1) {
      _operatingItemsYearly.add(OperatingChartItem(
        actYear,
        0,
        sumGeneratedPower,
        sumConsumedPower,
        sumFeedPower,
        sumWater,
        sumHeating,
      ));
    }

    // print(responseString);
  }

  List<OperatingChartItem> get operatingItems {
    return [..._operatingItems];
  }

  List<OperatingChartItem> get operatingItemsYearly {
    return [..._operatingItemsYearly];
  }

  Future<void> addSolarPowerEntry(double value) async {
    final insertDate = DateUtil.getInsertDate();
    Map<String, String> params = {
      'inputHausJahr': insertDate.year.toString(),
      'inputHausMonat': insertDate.month.toString(),
      'inputStromSolar': value.toInt().toString(),
    };
    await sendAndFetchData_(params);
    notifyListeners();
  }

  Future<void> addOperatingEntry(
      double water, double consumedPower, double feedPower, double heatingHT, double heatingNT) async {
    final insertDate = DateUtil.getInsertDate();
    Map<String, String> params = {
      'inputHausJahr': insertDate.year.toString(),
      'inputHausMonat': insertDate.month.toString(),
      'inputWasser': water.toInt().toString(),
      'inputStrom': consumedPower.toInt().toString(),
      'inputStromEinspeisung': feedPower.toInt().toString(),
      'inputStromWP_HT': heatingHT.toInt().toString(),
      'inputStromWP_NT': heatingNT.toInt().toString(),
    };
    await sendAndFetchData_(params);
    notifyListeners();
  }
}
