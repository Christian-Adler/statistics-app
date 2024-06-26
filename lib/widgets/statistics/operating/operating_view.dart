import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/hide_bottom_navigation_bar.dart';
import 'package:flutter_commons/widgets/layout/center_horizontal.dart';
import 'package:flutter_commons/widgets/layout/single_child_scroll_view_with_scrollbar.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../providers/operating.dart';
import '../../../utils/charts.dart';
import '../../../utils/dialog_utils.dart';
import '../../scroll_footer.dart';
import '../centered_error_text.dart';
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
      onRefresh: () async {
        try {
          await Provider.of<Operating>(context, listen: false).fetchData();
        } catch (e) {
          await DialogUtils.showSimpleOkErrDialog(e, context);
        }
      },
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
    return Provider.of<Operating>(context, listen: false)
        .fetchDataIfNotYetLoaded();
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
    TextSpan buildTooltipExt(double chargePerMonth, double chargePerValue,
        double value, double xValue, int seriesIdx) {
      if (!widget.showYearly) {
        return TextSpan(
            text: ' (${DateTime.now().year - 5 + seriesIdx})',
            // only the act and last 5 years are displayed
            style: Charts.tooltipExtStyle);
      }
      return TextSpan(
          text:
              '\n${(chargePerMonth * (widget.showYearly ? 12 : 1) + value * chargePerValue).ceil().toStringAsFixed(0)}€ (20${xValue.toStringAsFixed(0)})',
          style: Charts.tooltipExtStyle);
    }

    return FutureBuilder(
      future: _operatingDataFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        } else if (dataSnapshot.hasError) {
          return CenteredErrorText(dataSnapshot.error!);
        } else {
          return SingleChildScrollViewWithScrollbar(
            scrollPositionHandler: HideBottomNavigationBar.setScrollPosition,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                        S.of(context).operatingTitle(widget.showYearly
                            ? S.of(context).operatingTitlePeriodYear
                            : S.of(context).operatingTitlePeriodMonth),
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OperatingChart(
                    title: S.of(context).operatingChartWater,
                    baseColor: const Color.fromRGBO(51, 255, 255, 1),
                    maxHue: 70,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.water,
                    provideTooltipExt: (xValue, yValue, seriesIdx) => [
                      buildTooltipExt(
                          Operating.chargePerMonthWater,
                          Operating.chargePerValueWater,
                          yValue,
                          xValue,
                          seriesIdx)
                    ],
                  ),
                  const _ChartDivider(),
                  OperatingChart(
                    title: S.of(context).operatingChartHeating,
                    baseColor: const Color.fromRGBO(255, 0, 255, 1),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) => operatingItem.heating,
                    provideTooltipExt: (xValue, yValue, seriesIdx) => [
                      buildTooltipExt(
                          Operating.chargePerMonthHeating,
                          Operating.chargePerValueHeating,
                          yValue,
                          xValue,
                          seriesIdx)
                    ],
                  ),
                  const _ChartDivider(),
                  OperatingChart(
                    title: S.of(context).operatingChartPowerConsumed,
                    baseColor: const Color.fromRGBO(255, 220, 0, 1.0),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) =>
                        operatingItem.consumedPower,
                    provideTooltipExt: (xValue, yValue, seriesIdx) => [
                      buildTooltipExt(
                          Operating.chargePerMonthConsumedPower,
                          Operating.chargePerValueConsumedPower,
                          yValue,
                          xValue,
                          seriesIdx)
                    ],
                  ),
                  const _ChartDivider(),
                  OperatingChart(
                    title: S.of(context).operatingChartPowerGenerated,
                    baseColor: const Color.fromRGBO(117, 49, 255, 1.0),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) =>
                        operatingItem.generatedPower,
                    provideTooltipExt: (xValue, yValue, seriesIdx) => [
                      buildTooltipExt(0, Operating.chargePerValueConsumedPower,
                          yValue, xValue, seriesIdx)
                    ],
                  ),
                  const _ChartDivider(),
                  OperatingChart(
                    title: S.of(context).operatingChartPowerFed,
                    baseColor: const Color.fromRGBO(224, 152, 0, 1.0),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) =>
                        operatingItem.feedPower,
                    provideTooltipExt: (xValue, yValue, seriesIdx) => [
                      buildTooltipExt(0, Operating.chargePerValueConsumedPower,
                          yValue, xValue, seriesIdx)
                    ],
                  ),
                  const _ChartDivider(),
                  OperatingChart(
                    title: S
                        .of(context)
                        .operatingChartPowerGeneratedOwnConsumption,
                    baseColor: const Color.fromRGBO(194, 224, 0, 1.0),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) =>
                        operatingItem.generatedPower - operatingItem.feedPower,
                    provideTooltipExt: (xValue, yValue, seriesIdx) => [
                      buildTooltipExt(0, Operating.chargePerValueConsumedPower,
                          yValue, xValue, seriesIdx)
                    ],
                  ),
                  const _ChartDivider(),
                  OperatingChart(
                    title: S.of(context).operatingChartPowerConsumedTotal,
                    baseColor: const Color.fromRGBO(255, 220, 0, 1.0),
                    maxHue: -50,
                    showYearly: widget.showYearly,
                    getOperatingValue: (operatingItem) =>
                        operatingItem.consumedPower +
                        operatingItem.generatedPower -
                        operatingItem.feedPower,
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
