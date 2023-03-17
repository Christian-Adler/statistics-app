import 'package:flutter/foundation.dart';
import 'package:statistics/models/car/car_refuel_item.dart';

import '../utils/http_utils.dart';
import 'auth.dart';

class Car with ChangeNotifier {
  final Auth? _auth;
  final List<CarRefuelItem> _carRefuelItems;

  Car(this._auth, this._carRefuelItems);

  Future<void> fetchDataIfNotYetLoaded() async {
    if (_carRefuelItems.isEmpty) {
      await sendAndFetchData_(null);
      notifyListeners();
    }
  }

  Future<void> fetchData() async {
    await sendAndFetchData_(null);
    notifyListeners();
  }

  Future<void> sendAndFetchData_(Map<String, String>? params) async {
    if (_auth == null) return;

    final result = await HttpUtils.sendRequest('auto', params, _auth!);

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

  String _num2Two(int num) {
    String res = num.toString();
    if (res.length < 2) {
      res = '0$res';
    }
    return res;
  }

  Future<void> addCarRefuelEntry(double liter, int centPerLiter, int km) async {
    final insertDate = DateTime.now();
    Map<String, String> params = {
      'inputAutoDate': '${insertDate.year}-${_num2Two(insertDate.month)}-${_num2Two(insertDate.day)}',
      'inputLiter': liter.toString(),
      'inputCent': centPerLiter.toString(),
      'inputKm': km.toString(),
    };
    await sendAndFetchData_(params);
    notifyListeners();
  }
}
