import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/operating.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/operating/operating_chart.dart';
import '../../widgets/operating/operating_floating_button.dart';
import '../../widgets/statistics_app_bar.dart';
import 'solar_power_add_value_screen.dart';

class OperatingScreen extends StatefulWidget {
  static const String routeName = '/operating_screen';

  const OperatingScreen({Key? key}) : super(key: key);

  @override
  State<OperatingScreen> createState() => _OperatingScreenState();
}

class _OperatingScreenState extends State<OperatingScreen> {
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
        const Text('Betriebskosten'),
        context,
        actions: [
          IconButton(
            onPressed: () => _toggleYearly(),
            tooltip: 'Zeige ${_showYearly ? 'Monatsansicht' : 'Jahresansicht'}',
            icon: Icon(_showYearly ? Icons.calendar_month_outlined : Icons.calendar_today_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(SolarPowerAddValueScreen.routeName),
            tooltip: 'Betriebskosten Eintrag erstellen...',
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<Operating>(context, listen: false).fetchData(),
        child: _Operating(_showYearly),
      ),
      floatingActionButton: const OperatingFloatingButton(),
    );
  }
}

class _Operating extends StatefulWidget {
  final bool showYearly;

  const _Operating(this.showYearly);

  @override
  State<_Operating> createState() => _OperatingState();
}

class _OperatingState extends State<_Operating> {
  late Future _operatingDataFuture;

  Future _obtainSolarDataFuture() {
    return Provider.of<Operating>(context, listen: false).fetchDataIfNotYetLoaded();
  }

  @override
  void initState() {
    // Falls build aufgrund anderer state-Aenderungen mehrmals ausgefuehrt wuerde.
    // Future nur einmal ausfuehren und speichern.
    _operatingDataFuture = _obtainSolarDataFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _operatingDataFuture,
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
              padding: const EdgeInsets.all(10.0),
              child: Text('Error occurred:${dataSnapshot.error?.toString() ?? ''}'),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text('Betriebskosten / ${widget.showYearly ? 'Jahr' : 'Monat'}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge),
                  const SizedBox(
                    height: 20,
                  ),
                  OperatingChart(
                    title: 'Wasser (m³)',
                    baseColor: const Color.fromRGBO(51, 255, 255, 1),
                    maxHue: 70,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.water,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  OperatingChart(
                    title: 'Strom (kWh)',
                    baseColor: const Color.fromRGBO(255, 255, 0, 1),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.consumedPower,
                  ), const SizedBox(
                    height: 30,
                  ),
                  OperatingChart(
                    title: 'Strom Erzeugt (kWh)',
                    baseColor: const Color.fromRGBO(85, 0, 255, 1.0),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.generatedPower,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  OperatingChart(
                    title: 'Strom Eingespeist (kWh)',
                    baseColor: const Color.fromRGBO(0, 234, 255, 1.0),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.feedPower,
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  OperatingChart(
                    title: 'Heizung (kWh)',
                    baseColor: const Color.fromRGBO(255, 0, 255, 1),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.heating,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
