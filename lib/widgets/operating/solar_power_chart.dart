import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/providers/operating.dart';

import '../../models/globals.dart';

class SolarPowerChart extends StatelessWidget {
  const SolarPowerChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final powerData = Provider.of<Operating>(context);

    final List<FlSpot> spots = [];
    var idx = 0.0;
    powerData.solarPowerItems.forEach((element) {
      idx += 1;
      spots.add(
        FlSpot(idx, element.value),
      );
    });

    return Column(children: [
      ...powerData.solarPowerItems
          .map((powerChartItem) =>
              Text(powerChartItem.value.toString() + ' ' + Globals.getMonthShort(powerChartItem.month)))
          .toList(),
      Container(
        width: double.infinity,
        height: 200,
        child: AspectRatio(
          aspectRatio: 1.5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: LineChart(
              LineChartData(
                minY: -1,
                maxY: 30,
                minX: 0,
                maxX: 10,
                lineTouchData: LineTouchData(enabled: false),
                clipData: FlClipData.all(),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    // spots: [
                    //   FlSpot(1, 0.5),
                    //   FlSpot(2, 0.7),
                    //   FlSpot(3, -1.0),
                    //   FlSpot(10, 0.5),
                    // ],
                    spots: spots,
                    dotData: FlDotData(
                      show: false,
                    ),
                    gradient: const LinearGradient(
                      colors: [Colors.greenAccent, Colors.purple],
                      stops: [0.1, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    barWidth: 4,
                    isCurved: false,
                  ),
                ],
                titlesData: FlTitlesData(
                  show: false,
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
