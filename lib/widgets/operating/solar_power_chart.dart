import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/operating.dart';
import '../../utils/charts.dart';

class SolarPowerChart extends StatelessWidget {
  const SolarPowerChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final colorScheme = Theme.of(context).colorScheme;

    final powerData = Provider.of<Operating>(context);

    final chartMeta = powerData.solarPowerChartMetaData;

    final List<FlSpot> spots = [];
    for (var item in powerData.solarPowerItems) {
      spots.add(FlSpot(item.xValue, item.value));
    }

    final gradientColors = [colorScheme.primary, colorScheme.secondary];

    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Text('kWh / Monat', style: Theme.of(context).textTheme.titleLarge),
      ),
      Charts.createChartContainer(
          Charts.createLineChartMonthlyData(chartMeta, [
            Charts.createLineChartBarData(spots, gradientColors),
          ]),
          orientation),
    ]);
  }
}
