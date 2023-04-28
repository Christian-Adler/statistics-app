import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/screen_nav_info.dart';
import '../../providers/operating.dart';
import '../../utils/charts.dart';
import '../../widgets/add_value_floating_button.dart';
import '../../widgets/navigation/app_drawer.dart';
import '../../widgets/operating/operating_chart.dart';
import '../../widgets/scroll_footer.dart';
import '../../widgets/statistics_app_bar.dart';
import 'operating_add_value_screen.dart';

class OperatingScreen extends StatefulWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Nebenkosten', Icons.power_input_outlined, '/operating');

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
        Text(OperatingScreen.screenNavInfo.title),
        context,
        actions: [
          IconButton(
            onPressed: () => _toggleYearly(),
            tooltip: 'Zeige ${_showYearly ? 'Monatsansicht' : 'Jahresansicht'}',
            icon: Icon(_showYearly ? Icons.calendar_month_outlined : Icons.calendar_today_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(OperatingAddValueScreen.screenNavInfo.routeName),
            tooltip: OperatingAddValueScreen.screenNavInfo.title,
            icon: Icon(OperatingAddValueScreen.screenNavInfo.iconData),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<Operating>(context, listen: false).fetchData(),
        child: _Operating(_showYearly),
      ),
      floatingActionButton: const AddValueFloatingButton(),
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
    TextSpan buildTooltipExt(double chargePerMonth, double chargePerValue, double value) {
      return TextSpan(
          text:
              '\n${(chargePerMonth * (widget.showYearly ? 12 : 1) + value * chargePerValue).ceil().toStringAsFixed(0)}€',
          style: Charts.tooltipExtStyle);
    }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Betriebskosten / ${widget.showYearly ? 'Jahr' : 'Monat'}',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 20,
                  ),
                  OperatingChart(
                    title: 'Wasser (m³)',
                    baseColor: const Color.fromRGBO(51, 255, 255, 1),
                    maxHue: 70,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.water,
                    provideTooltipExt: widget.showYearly
                        ? (yValue, seriesIdx) =>
                            [buildTooltipExt(Operating.chargePerMonthWater, Operating.chargePerValueWater, yValue)]
                        : null,
                  ),
                  const _ChartDivider(),
                  OperatingChart(
                    title: 'Heizung (kWh)',
                    baseColor: const Color.fromRGBO(255, 0, 255, 1),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.heating,
                    provideTooltipExt: widget.showYearly
                        ? (yValue, seriesIdx) =>
                            [buildTooltipExt(Operating.chargePerMonthHeating, Operating.chargePerValueHeating, yValue)]
                        : null,
                  ),
                  const _ChartDivider(),
                  OperatingChart(
                    title: 'Strom (kWh)',
                    baseColor: const Color.fromRGBO(255, 220, 0, 1.0),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.consumedPower,
                    provideTooltipExt: widget.showYearly
                        ? (yValue, seriesIdx) => [
                              buildTooltipExt(
                                  Operating.chargePerMonthConsumedPower, Operating.chargePerValueConsumedPower, yValue)
                            ]
                        : null,
                  ),
                  const _ChartDivider(),
                  OperatingChart(
                    title: 'Strom Erzeugt (kWh)',
                    baseColor: const Color.fromRGBO(117, 49, 255, 1.0),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.generatedPower,
                    provideTooltipExt: widget.showYearly
                        ? (yValue, seriesIdx) => [buildTooltipExt(0, Operating.chargePerValueConsumedPower, yValue)]
                        : null,
                  ),
                  const _ChartDivider(),
                  OperatingChart(
                    title: 'Strom Eingespeist (kWh)',
                    baseColor: const Color.fromRGBO(224, 152, 0, 1.0),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.feedPower,
                    provideTooltipExt: widget.showYearly
                        ? (yValue, seriesIdx) => [buildTooltipExt(0, Operating.chargePerValueConsumedPower, yValue)]
                        : null,
                  ),
                  const _ChartDivider(),
                  OperatingChart(
                    title: 'Strom Erzeugt Eigenverbrauch (kWh)',
                    baseColor: const Color.fromRGBO(194, 224, 0, 1.0),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.generatedPower - operatingItem.feedPower,
                    provideTooltipExt: widget.showYearly
                        ? (yValue, seriesIdx) => [buildTooltipExt(0, Operating.chargePerValueConsumedPower, yValue)]
                        : null,
                  ),
                  const _ChartDivider(),
                  OperatingChart(
                    title: 'Strom Verbrauch gesamt (kWh)',
                    baseColor: const Color.fromRGBO(255, 220, 0, 1.0),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) =>
                        operatingItem.consumedPower + operatingItem.generatedPower - operatingItem.feedPower,
                  ),
                  const _ChartDivider(),
                  const ScrollFooter(),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class _ChartDivider extends StatelessWidget {
  const _ChartDivider();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
    );
  }
}
