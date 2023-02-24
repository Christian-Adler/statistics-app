import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/providers/operating.dart';

import '../../widgets/app_drawer.dart';
import '../../widgets/operating/operating_floating_button.dart';
import '../../widgets/operating/solar_power_chart.dart';
import '../../widgets/operating/solar_power_table.dart';
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
      body: const SingleChildScrollView(
        child: SolarPower(),
      ),
      floatingActionButton: const OperatingFloatingButton(),
    );
  }
}

class SolarPower extends StatefulWidget {
  const SolarPower({
    super.key,
  });

  @override
  State<SolarPower> createState() => _SolarPowerState();
}

class _SolarPowerState extends State<SolarPower> {
  late Future _solarDataFuture;

  Future _obtainSolarDataFuture() {
    return Provider.of<Operating>(context, listen: false).fetchData();
  }

  @override
  void initState() {
    // Falls build aufgrund anderer state-Aenderungen mehrmals ausgefuehrt wuerde.
    // Future nur einmal ausfuehren und speichern.
    _solarDataFuture = _obtainSolarDataFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _solarDataFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (dataSnapshot.hasError) {
          // .. do error handling
          return Center(
            child: Text('Error occurred:${dataSnapshot.error?.toString() ?? ''}'),
          );
        } else {
          return Column(
            children: const [
              SolarPowerChart(),
              SizedBox(
                height: 20,
              ),
              SolarPowerTable(),
            ],
          );
        }
      },
    );
  }
}
