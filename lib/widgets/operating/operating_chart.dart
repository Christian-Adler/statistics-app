import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/models/chart/operating_chart_item.dart';
import 'package:statistics/utils/color_utils.dart';

import '../../models/chart/chart_meta_data.dart';
import '../../providers/operating.dart';
import '../../utils/charts.dart';

class OperatingChart extends StatelessWidget {
  final bool showYearly;
  final String title;
  final Color baseColor;

  final double maxHue;

  final double Function(OperatingChartItem) getOperatingValue;

  const OperatingChart(
      {Key? key,
      required this.getOperatingValue,
      required this.title,
      required this.baseColor,
      required this.maxHue,
      required this.showYearly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    final powerData = Provider.of<Operating>(context);

    var operatingItems = showYearly ? powerData.operatingItemsYearly : powerData.operatingItems;
    int showLastXItems = 72;
    if (operatingItems.length > showLastXItems) {
      operatingItems = operatingItems.sublist(operatingItems.length - showLastXItems);
    }
    final chartMeta = ChartMetaData();
    chartMeta.yearly = showYearly;
    chartMeta.showYearOnJan = false;
    chartMeta.showDots = showYearly;

    final gradientColors = [baseColor, baseColor];

    List<LineChartBarData>? lineBarsData = [];
    final Map<String, _LineData> lineData = {};

    if (showYearly) {
      lineData['0'] = _LineData(gradientColors);
      for (var item in operatingItems) {
        var xVal = item.xValueYearly;
        var yVal = getOperatingValue(item);
        lineData['0']?.spots.add(FlSpot(xVal, yVal));
        chartMeta.putAll(xVal, [yVal]);
      }
    } else {
      final actYear = DateTime.now().year;

      lineData['0'] = _LineData(gradientColors);
      for (var i = 1; i <= 5; ++i) {
        lineData['$i'] = _LineData(gradientColors.map((c) => ColorUtils.hue(c, maxHue * i / 5)).toList());
      }

      for (var item in operatingItems) {
        var xVal = item.month;
        final key = actYear - item.year;
        if (key >= 0 && key <= 5) {
          var yVal = getOperatingValue(item);
          lineData['$key']?.spots.add(FlSpot(xVal.toDouble(), yVal));
          chartMeta.putAll(xVal, [yVal]);
        }
      }
    }

    for (var key = lineData.length - 1; key >= 0; --key) {
      final item = lineData['$key'];
      if (item != null) {
        lineBarsData.add(Charts.createLineChartBarData(
          item.spots,
          barWidth: 2,
          item.gradient,
          fillColors: [item.gradient.first.withOpacity(0.8), item.gradient.first.withOpacity(0)],
          chartMetaData: chartMeta,
        ));
      }
    }

    chartMeta.calcPadding();

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.left,
        ),
      ),
      Charts.createChartContainer(Charts.createLineChartData(chartMeta, fractionDigits: 0, lineBarsData), orientation),
    ]);
  }
}

class _LineData {
  final List<FlSpot> spots = [];
  final List<Color> gradient;

  _LineData(this.gradient);
}
