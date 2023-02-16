import 'package:flutter/material.dart';
import 'package:statistics/widgets/operating/solar_power_table.dart';

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
          children: const [
            SolarPowerChart(),
            SolarPowerTable(),
          ],
        ),
      ),
      floatingActionButton: const OperatingFloatingButton(),
    );
  }
}
