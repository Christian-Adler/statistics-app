class BloodPressureItem {
  final String date;
  List<BloodPressureValue> morning = [];
  List<BloodPressureValue> midday = [];
  List<BloodPressureValue> evening = [];

  BloodPressureItem(this.date);
}

class BloodPressureValue {
  final int high;
  final int low;

  BloodPressureValue(this.high, this.low);
}
