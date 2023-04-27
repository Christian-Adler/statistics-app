import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/screen_nav_info.dart';
import '../../providers/operating.dart';
import '../../widgets/add_value_floating_button.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/operating/solar_power_chart.dart';
import '../../widgets/operating/solar_power_table.dart';
import '../../widgets/scroll_footer.dart';
import '../../widgets/statistics_app_bar.dart';
import 'solar_power_add_value_screen.dart';

class SolarPowerScreen extends StatefulWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Solar-Strom', Icons.solar_power_outlined, '/solar_power');

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
        Text(SolarPowerScreen.screenNavInfo.title),
        context,
        actions: [
          IconButton(
            onPressed: () => _toggleYearly(),
            tooltip: 'Zeige ${_showYearly ? 'Monatsansicht' : 'Jahresansicht'}',
            icon: Icon(_showYearly ? Icons.calendar_month_outlined : Icons.calendar_today_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(SolarPowerAddValueScreen.screenNavInfo.routeName),
            tooltip: SolarPowerAddValueScreen.screenNavInfo.title,
            icon: Icon(SolarPowerAddValueScreen.screenNavInfo.iconData),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<Operating>(context, listen: false).fetchData(),
        child: _SolarPower(_showYearly),
      ),
      floatingActionButton: const AddValueFloatingButton(),
    );
  }
}

class _SolarPower extends StatefulWidget {
  final bool showYearly;

  const _SolarPower(this.showYearly);

  @override
  State<_SolarPower> createState() => _SolarPowerState();
}

class _SolarPowerState extends State<_SolarPower> {
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
              padding: const EdgeInsets.all(10.0),
              child: Text('Error occurred:${dataSnapshot.error?.toString() ?? ''}'),
            ),
          );
        } else {
          return Scrollbar(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text('kWh / ${widget.showYearly ? 'Jahr' : 'Monat'}',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(
                      height: 10,
                    ),
                    SolarPowerChart(widget.showYearly),
                    const SizedBox(
                      height: 20,
                    ),
                    SolarPowerTable(widget.showYearly),
                    const ScrollFooter(
                      marginTop: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
