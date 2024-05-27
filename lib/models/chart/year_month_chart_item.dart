import '../../utils/date_utils.dart';
import 'abstract_chart_item.dart';

class YearMonthChartItem extends AbstractChartItem {
  final int year;
  final int month;

  YearMonthChartItem(this.year, this.month, super.value);

  double get xValueMonthly {
    return (year * 12 + month).toDouble();
  }

  double get xValueYearly {
    // return (year).toDouble();
    return (year % 100).toDouble();
  }

  String get xLabel {
    var label = DateUtil.getMonthShort(month);
    if (month == 1) {
      label += '\n$year';
    }
    return label;
  }
}
