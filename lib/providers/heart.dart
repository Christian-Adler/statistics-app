import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../models/heart/blood_pressure_item.dart';
import '../utils/http_utils.dart';
import 'auth.dart';

class Heart with ChangeNotifier {
  final Auth? _auth;
  final List<BloodPressureItem> _bloodPressureItems;

  Heart(this._auth, this._bloodPressureItems);

  Future<void> fetchDataIfNotYetLoaded() async {
    if (_bloodPressureItems.isEmpty) {
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

    final result = await HttpUtils.sendRequest('bloodpressure', params, _auth!);

    final dataList = result['data'] as List<dynamic>;
    _bloodPressureItems.clear();

    final List<String> keys = [];
    final Map<String, BloodPressureItem> date2Item = {};

    for (var item in dataList) {
      final map = item as Map<String, dynamic>;

      final ts = map['timestamp'];
      final timestamp = ts is int ? ts : (ts as double).toInt(); // echter Server liefert double!?
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: false);
      final key = DateFormat('yyyy-MM-dd').format(date);
      if (!date2Item.containsKey(key)) keys.add(key);
      var bloodPressureItem = date2Item.putIfAbsent(key, () => BloodPressureItem(date));

      var high = (map['high'] as int);
      var low = (map['low'] as int);
      var bloodPressureValue = BloodPressureValue(high, low);
      if (date.hour < 10) {
        bloodPressureItem.morning.add(bloodPressureValue);
      } else if (date.hour > 15) {
        bloodPressureItem.evening.add(bloodPressureValue);
      } else {
        bloodPressureItem.midday.add(bloodPressureValue);
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
    await _sendAndFetchData(params);
    notifyListeners();
  }
}
