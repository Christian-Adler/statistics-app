import '../../utils/globals.dart';
import 'abstract_chart_item.dart';

class YearMonthChartItem extends AbstractChartItem {
  final int year;
  final int month;

  YearMonthChartItem(this.year, this.month, super.value);

  double get xValue {
    return (year * 12 + month).toDouble();
  }

  String get xLabel {
    var label = Globals.getMonthShort(month);
    if (month == 1) {
      label += '\n$year';
    }
    return label;
  }
}
