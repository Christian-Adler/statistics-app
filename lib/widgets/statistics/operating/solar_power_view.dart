import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/operating.dart';
import '../../layout/single_child_scroll_view_with_scrollbar.dart';
import '../../scroll_footer.dart';
import 'display/solar_power_chart.dart';
import 'display/solar_power_table.dart';

class SolarPowerView extends StatelessWidget {
  final bool _showYearly;

  const SolarPowerView({super.key,
    required bool showYearly,
  }) : _showYearly = showYearly;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Provider.of<Operating>(context, listen: false).fetchData(),
      child: _SolarPower(_showYearly),
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
          return SingleChildScrollViewWithScrollbar(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text('kWh / ${widget.showYearly ? 'Jahr' : 'Monat'}', style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge),
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
          );
        }
      },
    );
  }
}
