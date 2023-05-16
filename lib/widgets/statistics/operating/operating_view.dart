import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/operating.dart';
import '../../../utils/charts.dart';
import '../../../utils/hide_bottom_navigation_bar.dart';
import '../../layout/center_horizontal.dart';
import '../../layout/single_child_scroll_view_with_scrollbar.dart';
import '../../scroll_footer.dart';
import 'display/operating_chart.dart';

class OperatingView extends StatelessWidget {
  const OperatingView({
    super.key,
    required bool showYearly,
  }) : _showYearly = showYearly;

  final bool _showYearly;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Provider.of<Operating>(context, listen: false).fetchData(),
      child: _Operating(_showYearly),
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
          return const LinearProgressIndicator();
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
            scrollDirectionCallback: HideBottomNavigationBar.setScrollDirection,
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
                  const CenterH(child: ScrollFooter()),
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
