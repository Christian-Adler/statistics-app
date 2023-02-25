import 'year_month_chart_item.dart';

class OperatingChartItem extends YearMonthChartItem {
  final double water;
  final double generatedPower;
  final double consumedPower;
  final double feedPower;
  final double totalUsedPower;
  final double heating;

  OperatingChartItem(
    int year,
    int month,
    this.generatedPower,
    this.consumedPower,
    this.feedPower,
    this.water,
    this.heating,
  )   : totalUsedPower = consumedPower + generatedPower - feedPower,
        super(year, month, generatedPower);
}
