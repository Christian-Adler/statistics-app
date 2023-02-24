import 'package:statistics/models/chart/year_month_chart_item.dart';

class SolarPowerChartItem extends YearMonthChartItem {
  final double generatedPower;
  final double consumedPower;
  final double feedPower;

  SolarPowerChartItem(
    int year,
    int month,
    this.generatedPower,
    this.consumedPower,
    this.feedPower,
  ) : super(year, month, generatedPower);
}
