class BloodPressureItem {
  final String date;
  BloodPressureValue? morning;
  BloodPressureValue? midday;
  BloodPressureValue? evening;

  BloodPressureItem(this.date);
}

class BloodPressureValue {
  final int high;
  final int low;

  BloodPressureValue(this.high, this.low);
}
