import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/chart/chart_meta_data.dart';
import '../../models/chart/legend_item.dart';
import '../../providers/operating.dart';
import '../../utils/charts.dart';
import 'simple_legend.dart';

class SolarPowerChart extends StatelessWidget {
  const SolarPowerChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    var themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;

    final powerData = Provider.of<Operating>(context);

    var solarPowerItems = powerData.solarPowerItems;
    int showLastXItems = 12;
    if (solarPowerItems.length > showLastXItems) {
      solarPowerItems = solarPowerItems.sublist(solarPowerItems.length - showLastXItems);
    }
    final chartMeta = ChartMetaData();

    final List<FlSpot> spotsGeneratedPower = [];
    final List<FlSpot> spotsConsumedPower = [];
    final List<FlSpot> spotsFeedPower = [];
    for (var item in solarPowerItems) {
      chartMeta.putAll(item.xValue, [item.generatedPower, item.consumedPower, item.feedPower]);
      spotsGeneratedPower.add(FlSpot(item.xValue, item.generatedPower));
      spotsConsumedPower.add(FlSpot(item.xValue, item.consumedPower));
      spotsFeedPower.add(FlSpot(item.xValue, item.feedPower));
    }

    chartMeta.calcPadding();

    final gradientColorsGeneratedPower = [themeData.colorScheme.primary, themeData.colorScheme.secondary];
    final gradientColorsConsumedPower = [Colors.redAccent, Colors.orangeAccent];
    final gradientColorsFeedPower = [Colors.cyanAccent, Colors.cyanAccent.withOpacity(0.1)];

    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Text('kWh / Monat', style: themeData.textTheme.titleLarge),
      ),
      Charts.createChartContainer(
          Charts.createLineChartMonthlyData(chartMeta, [
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
                  themeData.colorScheme.primary.withOpacity(0.5),
                  themeData.colorScheme.secondary.withOpacity(0)
                ]),
            Charts.createLineChartBarData(spotsFeedPower, gradientColorsFeedPower, shadow: false),
          ]),
          orientation),
      SimpleLegend(items: [
        LegendItem('Erzeugt', gradientColorsGeneratedPower),
        LegendItem('Eingespeist', gradientColorsFeedPower),
        LegendItem('Verbraucht', gradientColorsConsumedPower),
      ]),
    ]);
  }
}
