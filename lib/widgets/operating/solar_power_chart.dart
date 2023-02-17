import 'dart:math' as math;

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
    final List<FlSpot> spots2 = [];
    var toggle = false;
    for (var item in powerData.solarPowerItems) {
      spots.add(FlSpot(item.xValue, item.value));
      spots2.add(FlSpot(item.xValue, math.sqrt(item.value)));
      toggle = !toggle;
    }

    final gradientColors = [colorScheme.primary, colorScheme.secondary];
    final gradientColors2 = [Colors.redAccent, Colors.deepPurpleAccent.withOpacity(0.1)];

    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Text('kWh / Monat', style: Theme.of(context).textTheme.titleLarge),
      ),
      Charts.createChartContainer(
          Charts.createLineChartMonthlyData(chartMeta, [
            Charts.createLineChartBarData(spots2, gradientColors2,
                shadow: false, fillColors: gradientColors2.map((color) => color.withOpacity(0.5)).toList()),
            Charts.createLineChartBarData(spots, gradientColors),
          ]),
          orientation),
    ]);
  }
}
