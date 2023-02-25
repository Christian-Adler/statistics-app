import 'package:statistics/models/chart/year_month_chart_item.dart';

class SolarPowerChartItem extends YearMonthChartItem {
  final double generatedPower;
  final double consumedPower;
  final double feedPower;
  final double totalUsedPower;

  SolarPowerChartItem(
    int year,
    int month,
    this.generatedPower,
    this.consumedPower,
    this.feedPower,
  )   : totalUsedPower = consumedPower + generatedPower - feedPower,
        super(year, month, generatedPower);
}
