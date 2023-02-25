import '../../utils/globals.dart';
import 'abstract_chart_item.dart';

class YearMonthChartItem extends AbstractChartItem {
  final int year;
  final int month;

  YearMonthChartItem(this.year, this.month, super.value);

  double get xValueMonthly {
    return (year * 12 + month).toDouble();
  }

  double get xValueYearly {
    return (year).toDouble();
  }

  String get xLabel {
    var label = Globals.getMonthShort(month);
    if (month == 1) {
      label += '\n$year';
    }
    return label;
  }
}
