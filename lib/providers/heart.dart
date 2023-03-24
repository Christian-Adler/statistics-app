import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:statistics/models/heart/blood_pressure_item.dart';

import '../utils/http_utils.dart';
import 'auth.dart';

class Heart with ChangeNotifier {
  final Auth? _auth;
  final List<BloodPressureItem> _bloodPressureItems;

  Heart(this._auth, this._bloodPressureItems);

  Future<void> fetchDataIfNotYetLoaded() async {
    if (_bloodPressureItems.isEmpty) {
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

    final result = await HttpUtils.sendRequest('bloodpressure', params, _auth!);

    final dataList = result['data'] as List<dynamic>;
    _bloodPressureItems.clear();

    final List<String> keys = [];
    final Map<String, BloodPressureItem> date2Item = {};

    for (var item in dataList) {
      final map = item as Map<String, dynamic>;

      final timestamp = (map['timestamp'] as int);
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: false);
      final key = DateFormat('E, dd.MM.yyyy').format(date);
      if (!date2Item.containsKey(key)) keys.add(key);
      var bloodPressureItem = date2Item.putIfAbsent(key, () => BloodPressureItem(key));

      var high = (map['high'] as int);
      var low = (map['low'] as int);
      var bloodPressureValue = BloodPressureValue(high, low);
      if (date.hour < 10) {
        bloodPressureItem.morning = bloodPressureValue;
      } else if (date.hour > 15) {
        bloodPressureItem.evening = bloodPressureValue;
      } else {
        bloodPressureItem.midday = bloodPressureValue;
      }
    }

    for (var key in keys) {
      var item = date2Item[key];
      if (item != null) _bloodPressureItems.add(item);
    }

    // print(responseString);
  }

  List<BloodPressureItem> get bloodPressureItems {
    return [..._bloodPressureItems];
  }

  Future<void> addBloodPressureEntry(int high, int low) async {
    Map<String, String> params = {
      'inputHigh': high.toString(),
      'inputLow': low.toString(),
    };
    await sendAndFetchData_(params);
    notifyListeners();
  }
}
