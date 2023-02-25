import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/chart/operating_chart_item.dart';
import '../utils/http_utils.dart';
import 'auth.dart';

class Operating with ChangeNotifier {
  final Auth? auth;
  final List<OperatingChartItem> _operatingItems;
  final List<OperatingChartItem> _operatingItemsYearly;

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

    var authority = auth!.serverUrlWithoutProtocol;
    var unencodedPath = '/call/onstatistic.php';
    if (!authority.endsWith('de')) {
      // lokaler test
      unencodedPath = '/eagle$unencodedPath';
    }

    final uri = Uri.http(authority, unencodedPath);
    final request = http.MultipartRequest('POST', uri);
    final data = {
      'inputPassword': auth!.pw,
      'dataInputType': 'haus_nebenkosten',
    };
    if (params != null) {
      data.addAll(params);
    }

    HttpUtils.jsonToFormData(request, data);

    final response = await request.send();
    if (response.statusCode != 200) {
      throw HttpException('${response.reasonPhrase} (${response.statusCode})', uri: uri);
    }
    final responseBytes = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseBytes);
    final decoded = jsonDecode(responseString);
    if (decoded == null) return;

    final json = decoded as Map<String, dynamic>;
    if (!json.containsKey('returnCode')) {
      throw const FormatException('Invalid json: no returnCode');
    }
    final returnCode = json['returnCode'] as int;
    if (returnCode != 1) {
      throw Exception(json['error']);
    }

    final result = json['result'] as Map<String, dynamic>;
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
    final now = DateTime.now();
    Map<String, String> params = {
      'inputHausJahr': now.year.toString(),
      'inputHausMonat': now.month.toString(),
      'inputStromSolar': value.toInt().toString(),
    };
    await sendAndFetchData_(params);
    notifyListeners();
  }
}
