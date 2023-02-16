import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_drawer.dart';
import '../../widgets/operating/operating_floating_button.dart';
import '../../widgets/operating/solar_power_chart.dart';
import '../../widgets/statistics_app_bar.dart';
import 'insert_solar_power_value_screen.dart';

class SolarPowerChartScreen extends StatelessWidget {
  static const String routeName = '/solar_power_chart_screen';

  const SolarPowerChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        const Text('Solar Strom'),
        context,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(InsertSolarPowerValueScreen.routeName),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SolarPowerChart(),
            const SizedBox(
              height: 30,
            ),
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
                            FlSpot(3, -1.0),
                            FlSpot(10, 0.5),
                          ],
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
          ],
        ),
      ),
      floatingActionButton: const OperatingFloatingButton(),
    );
  }
}
