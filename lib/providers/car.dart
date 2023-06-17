import 'package:flutter/foundation.dart';
import 'package:flutter_simple_logging/flutter_simple_logging.dart';

import '../models/car/car_refuel_item.dart';
import '../utils/date_utils.dart';
import '../utils/error_code.dart';
import '../utils/http_utils.dart';
import 'auth.dart';

class Car with ChangeNotifier {
  final Auth? _auth;
  final List<CarRefuelItem> _carRefuelItems;

  Car(this._auth, this._carRefuelItems);

  Future<void> fetchDataIfNotYetLoaded() async {
    if (_carRefuelItems.isEmpty) {
      await _sendAndFetchData(null);
      notifyListeners();
    }
  }

  Future<void> fetchData() async {
    await _sendAndFetchData(null);
    notifyListeners();
  }

  Future<void> _sendAndFetchData(Map<String, String>? params) async {
    if (_auth == null) return;

    Map<String, dynamic> result;
    try {
      result = await HttpUtils.sendRequest('auto', params, _auth!);
    } catch (e) {
      if (params == null) {
        SimpleLogging.logger.w('Failed to load data from server.', e);
        throw ErrorCode.failedToLoadDataFromServer;
      } else {
        SimpleLogging.logger.w('Failed to send data to server.', e);
        throw ErrorCode.failedToSendDataToServer;
      }
    }

    final dataList = result['data'] as List<dynamic>;
    _carRefuelItems.clear();

    for (var item in dataList) {
      final map = item as Map<String, dynamic>;

      final date = (map['date'] as String);
      var liter = (map['liter'] as int);
      var centPerLiter = (map['centPerLiter'] as int);
      var km = (map['km'] as int);

      _carRefuelItems.add(CarRefuelItem(
        date,
        liter,
        centPerLiter,
        km,
      ));
    }

    // print(responseString);
  }

  List<CarRefuelItem> get carRefuelItems {
    return [..._carRefuelItems];
  }

  Future<void> addCarRefuelEntry(double liter, double centPerLiter, double km) async {
    final insertDate = DateTime.now();
    Map<String, String> params = {
      'inputAutoDate': '${insertDate.year}-${DateUtil.num2Two(insertDate.month)}-${DateUtil.num2Two(insertDate.day)}',
      'inputLiter': liter.toInt().toString(),
      'inputCent': centPerLiter.toInt().toString(),
      'inputKm': km.toInt().toString(),
    };
    await _sendAndFetchData(params);
    notifyListeners();
  }
}
