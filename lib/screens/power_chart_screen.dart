import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:statistics/widgets/app_drawer.dart';

import '../widgets/power/power_floating_button.dart';
import '../widgets/statistics_app_bar.dart';

class PowerChartScreen extends StatelessWidget {
  static const String routeName = '/power_chart_screen';

  const PowerChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        const Text('Strom'),
        context,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      // appBar: AppBar(),

      // appBar: GradientAppBar(title: Text('abc'), gradientColors: [Colors.black12, Colors.red]),

      drawer: const AppDrawer(),
      body: AspectRatio(
        aspectRatio: 1.5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: LineChart(
            LineChartData(
              minY: -1,
              maxY: 1,
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
                  spots: [
                    FlSpot(1, 0.5),
                    FlSpot(2, 0.7),
                    FlSpot(3, 0.2),
                    FlSpot(4, 0.5),
                  ],
                  dotData: FlDotData(
                    show: false,
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.purple],
                    stops: const [0.1, 1.0],
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
      floatingActionButton: const PowerFloatingButton(),
    );
  }
}
