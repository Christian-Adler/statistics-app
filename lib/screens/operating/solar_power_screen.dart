import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/operating.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/operating/operating_floating_button.dart';
import '../../widgets/operating/solar_power_chart.dart';
import '../../widgets/operating/solar_power_table.dart';
import '../../widgets/statistics_app_bar.dart';
import 'solar_power_add_value_screen.dart';

class SolarPowerScreen extends StatefulWidget {
  static const String routeName = '/solar_power_chart_screen';

  const SolarPowerScreen({Key? key}) : super(key: key);

  @override
  State<SolarPowerScreen> createState() => _SolarPowerScreenState();
}

class _SolarPowerScreenState extends State<SolarPowerScreen> {
  bool _showYearly = false;

  void _toggleYearly() {
    setState(() {
      _showYearly = !_showYearly;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        const Text('Solar Strom'),
        context,
        actions: [
          IconButton(
            onPressed: () => _toggleYearly(),
            tooltip: 'Zeige ${_showYearly ? 'Monatsansicht' : 'Jahresansicht'}',
            icon: Icon(_showYearly ? Icons.calendar_month_outlined : Icons.calendar_today_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(SolarPowerAddValueScreen.routeName),
            tooltip: 'Solar Eintrag erstellen...',
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<Operating>(context, listen: false).fetchData(),
        child: SingleChildScrollView(
          child: SolarPower(_showYearly),
        ),
      ),
      floatingActionButton: const OperatingFloatingButton(),
    );
  }
}

class SolarPower extends StatefulWidget {
  final showYearly;

  const SolarPower(
    this.showYearly, {
    super.key,
  });

  @override
  State<SolarPower> createState() => _SolarPowerState();
}

class _SolarPowerState extends State<SolarPower> {
  late Future _solarDataFuture;

  Future _obtainSolarDataFuture() {
    return Provider.of<Operating>(context, listen: false).fetchDataIfNotYetLoaded();
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
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (dataSnapshot.hasError) {
          // .. do error handling
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Error occurred:${dataSnapshot.error?.toString() ?? ''}'),
            ),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Text('kWh / ${widget.showYearly ? 'Jahr' : 'Monat'}',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              SolarPowerChart(widget.showYearly),
              const SizedBox(
                height: 20,
              ),
              SolarPowerTable(widget.showYearly),
            ],
          );
        }
      },
    );
  }
}
