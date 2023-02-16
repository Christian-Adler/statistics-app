import 'package:statistics/models/chart/abstract_chart_item.dart';

class YearMonthChartItem extends AbstractChartItem {
  final int year;
  final int month;

  YearMonthChartItem(this.year, this.month, super.value);
}
