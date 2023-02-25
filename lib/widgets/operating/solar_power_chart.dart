import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/chart/chart_meta_data.dart';
import '../../models/chart/legend_item.dart';
import '../../providers/operating.dart';
import '../../utils/charts.dart';
import 'simple_legend.dart';

class SolarPowerChart extends StatelessWidget {
  final bool showYearly;

  const SolarPowerChart(this.showYearly, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    var themeData = Theme.of(context);

    final powerData = Provider.of<Operating>(context);

    var solarPowerItems = showYearly ? powerData.operatingItemsYearly : powerData.operatingItems;
    int showLastXItems = 12;
    if (solarPowerItems.length > showLastXItems) {
      solarPowerItems = solarPowerItems.sublist(solarPowerItems.length - showLastXItems);
    }
    final chartMeta = ChartMetaData();
    chartMeta.yearly = showYearly;

    final List<FlSpot> spotsGeneratedPower = [];
    final List<FlSpot> spotsConsumedPower = [];
    final List<FlSpot> spotsFeedPower = [];
    final List<FlSpot> spotsSumUsedPower = [];
    for (var item in solarPowerItems) {
      var sumUsedPower = item.consumedPower + item.generatedPower - item.feedPower;
      var xVal = showYearly ? item.xValueYearly : item.xValueMonthly;
      chartMeta.putAll(xVal, [sumUsedPower, item.feedPower]);
      spotsGeneratedPower.add(FlSpot(xVal, item.generatedPower));
      spotsConsumedPower.add(FlSpot(xVal, item.consumedPower));
      spotsFeedPower.add(FlSpot(xVal, item.feedPower));
      spotsSumUsedPower.add(FlSpot(xVal, sumUsedPower));
    }

    chartMeta.calcPadding();

    final gradientColorsGeneratedPower = [themeData.colorScheme.primary, themeData.colorScheme.secondary];
    final gradientColorsConsumedPower = [Colors.redAccent, Colors.orangeAccent];
    final gradientColorsFeedPower = [Colors.yellow, Colors.orangeAccent.withOpacity(0.1)];
    final gradientColorsSumUsedPower = [Colors.redAccent, Colors.orangeAccent];

    return Column(children: [
      Charts.createChartContainer(
          Charts.createLineChartData(chartMeta, fractionDigits: 0, [
            Charts.createLineChartBarData(
              spotsSumUsedPower,
              gradientColorsSumUsedPower,
              shadow: false,
              dashArray: [2, 4],
              barWidth: 2,
            ),
            Charts.createLineChartBarData(
              spotsConsumedPower, gradientColorsConsumedPower,
              shadow: false,
              fillColors: [
                Colors.redAccent.withOpacity(0.5),
                Colors.orangeAccent.withOpacity(0.2),
                Colors.orangeAccent.withOpacity(0.0),
                Colors.orangeAccent.withOpacity(0)
              ],
              //fillColors: gradientColorsConsumedPower.map((color) => color.withOpacity(0.5)).toList(),
            ),
            Charts.createLineChartBarData(spotsGeneratedPower, gradientColorsGeneratedPower,
                shadow: false,
                fillColors: [
                  themeData.colorScheme.primary.withOpacity(0.9),
                  themeData.colorScheme.secondary.withOpacity(0.4)
                ]),
            Charts.createLineChartBarData(
              spotsFeedPower,
              gradientColorsFeedPower,
              shadow: false,
              dashArray: [2, 4],
              barWidth: 2,
            ),
          ]),
          orientation),
      const SizedBox(
        height: 10,
      ),
      LayoutBuilder(
        builder: (ctx, constraints) {
          if (constraints.maxWidth > 450) {
            return SimpleLegend(items: [
              LegendItem('Erzeugt', gradientColorsGeneratedPower),
              LegendItem('Eingespeist', gradientColorsFeedPower),
              LegendItem('Verbraucht', gradientColorsConsumedPower),
              LegendItem(
                  'Gesamt', [...gradientColorsSumUsedPower, Colors.white, ...gradientColorsSumUsedPower.reversed]),
            ]);
          } else {
            return Column(
              children: [
                SimpleLegend(items: [
                  LegendItem('Erzeugt', gradientColorsGeneratedPower),
                  LegendItem('Eingespeist', gradientColorsFeedPower),
                ]),
                const SizedBox(
                  height: 5,
                ),
                SimpleLegend(items: [
                  LegendItem('Verbraucht', gradientColorsConsumedPower),
                  LegendItem(
                      'Gesamt', [...gradientColorsSumUsedPower, Colors.white, ...gradientColorsSumUsedPower.reversed]),
                ]),
              ],
            );
          }
        },
      ),
    ]);
  }
}
