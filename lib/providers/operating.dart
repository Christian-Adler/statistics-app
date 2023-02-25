import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:statistics/models/chart/solar_power_chart_item.dart';
import 'package:statistics/utils/http_utils.dart';

import 'auth.dart';

class Operating with ChangeNotifier {
  final Auth? auth;
  final List<SolarPowerChartItem> _solarPowerItems;

  Operating(this.auth, this._solarPowerItems);

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
      'dataInputType': 'haus_solar',
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
    _solarPowerItems.clear();
    for (var item in dataList) {
      final map = item as Map<String, dynamic>;

      _solarPowerItems.add(SolarPowerChartItem(
          (map['jahr'] as int),
          (map['monat'] as int),
          (map['strom_solar'] as int).toDouble(),
          (map['strom'] as int).toDouble(),
          (map['strom_einspeisung'] as int).toDouble()));
    }

    // print(responseString);
  }

  List<SolarPowerChartItem> get solarPowerItems {
    return [..._solarPowerItems];
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
