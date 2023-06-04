import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/chart/chart_meta_data.dart';
import '../../../../models/chart/legend_item.dart';
import '../../../../providers/operating.dart';
import '../../../../utils/charts.dart';
import 'simple_legend.dart';

class SolarPowerChart extends StatelessWidget {
  final bool showYearly;

  const SolarPowerChart(this.showYearly, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    final powerData = Provider.of<Operating>(context);

    TextSpan buildTooltipExt(double chargePerMonth, double chargePerValue, double value, int seriesIdx) {
      // Gesamt
      if (seriesIdx == 0) return const TextSpan();
      // Verbrauch
      if (seriesIdx == 1) {
        return TextSpan(
            text: '\n${(chargePerMonth * (showYearly ? 12 : 1) + value * chargePerValue).ceil().toStringAsFixed(0)}€',
            style: Charts.tooltipExtStyle);
      }
      // Eingespeist
      if (seriesIdx == 3) {
        return TextSpan(
            text: '\n(- ${(value * chargePerValue).ceil().toStringAsFixed(0)}€)', style: Charts.tooltipExtStyle);
      }
      // Erzeugt
      return TextSpan(text: '\n+${(value * chargePerValue).ceil().toStringAsFixed(0)}€', style: Charts.tooltipExtStyle);
    }

    var solarPowerItems = showYearly ? powerData.operatingItemsYearly : powerData.operatingItems;
    int showLastXItems = 12;
    if (solarPowerItems.length > showLastXItems) {
      solarPowerItems = solarPowerItems.sublist(solarPowerItems.length - showLastXItems);
    }
    final chartMeta = ChartMetaData();
    chartMeta.yearly = showYearly;

    final List<FlSpot> spotsGeneratedPower = [];
    final List<FlSpot> spotsConsumedPower = [];
    final List<FlSpot> spotsFeedPower = [];
    final List<FlSpot> spotsSumUsedPower = [];
    for (var item in solarPowerItems) {
      var sumUsedPower = item.consumedPower + item.generatedPower - item.feedPower;
      var xVal = showYearly ? item.xValueYearly : item.xValueMonthly;
      chartMeta.putAll(xVal, [sumUsedPower, item.feedPower]);
      spotsGeneratedPower.add(FlSpot(xVal, item.generatedPower));
      spotsConsumedPower.add(FlSpot(xVal, item.consumedPower));
      spotsFeedPower.add(FlSpot(xVal, item.feedPower));
      spotsSumUsedPower.add(FlSpot(xVal, sumUsedPower));
    }

    chartMeta.calcPadding();

    final gradientColorsGeneratedPower = [Colors.purple, Colors.amber];
    final gradientColorsConsumedPower = [Colors.redAccent, Colors.orangeAccent];
    final gradientColorsFeedPower = [Colors.yellow, Colors.orangeAccent.withOpacity(0.1)];
    final gradientColorsSumUsedPower = [Colors.redAccent, Colors.orangeAccent];

    return Column(children: [
      Charts.createChartContainer(
          Charts.createLineChartData(
            chartMeta,
            fractionDigits: 0,
            [
              Charts.createLineChartBarData(
                spotsSumUsedPower,
                gradientColorsSumUsedPower,
                shadow: false,
                dashArray: [2, 4],
                barWidth: 2,
              ),
              Charts.createLineChartBarData(
                spotsConsumedPower, gradientColorsConsumedPower,
                shadow: false,
                fillColors: [
                  Colors.redAccent.withOpacity(0.5),
                  Colors.orangeAccent.withOpacity(0.2),
                  Colors.orangeAccent.withOpacity(0.0),
                  Colors.orangeAccent.withOpacity(0)
                ],
                //fillColors: gradientColorsConsumedPower.map((color) => color.withOpacity(0.5)).toList(),
              ),
              Charts.createLineChartBarData(
                spotsGeneratedPower,
                gradientColorsGeneratedPower,
                shadow: false,
                fillColors: [Colors.purple.withOpacity(0.9), Colors.amber.withOpacity(0.4)],
              ),
              Charts.createLineChartBarData(
                spotsFeedPower,
                gradientColorsFeedPower,
                shadow: false,
                dashArray: [2, 4],
                barWidth: 2,
              ),
            ],
            provideTooltipExt: (yValue, seriesIdx) => [
              buildTooltipExt(
                  Operating.chargePerMonthConsumedPower, Operating.chargePerValueConsumedPower, yValue, seriesIdx)
            ],
          ),
          orientation),
      const SizedBox(
        height: 10,
      ),
      LayoutBuilder(
        builder: (ctx, constraints) {
          if (constraints.maxWidth > 450) {
            return SimpleLegend(items: [
              LegendItem(S.of(context).solarPowerChartLegendItemGenerated, gradientColorsGeneratedPower),
              LegendItem(S.of(context).solarPowerChartLegendItemFed, gradientColorsFeedPower),
              LegendItem(S.of(context).solarPowerChartLegendItemConsumption, gradientColorsConsumedPower),
              LegendItem(S.of(context).solarPowerChartLegendItemTotal,
                  [...gradientColorsSumUsedPower, Colors.white, ...gradientColorsSumUsedPower.reversed]),
            ]);
          } else {
            return Column(
              children: [
                SimpleLegend(items: [
                  LegendItem(S.of(context).solarPowerChartLegendItemGenerated, gradientColorsGeneratedPower),
                  LegendItem(S.of(context).solarPowerChartLegendItemFed, gradientColorsFeedPower),
                ]),
                const SizedBox(
                  height: 5,
                ),
                SimpleLegend(items: [
                  LegendItem(S.of(context).solarPowerChartLegendItemConsumption, gradientColorsConsumedPower),
                  LegendItem(S.of(context).solarPowerChartLegendItemTotal,
                      [...gradientColorsSumUsedPower, Colors.white, ...gradientColorsSumUsedPower.reversed]),
                ]),
              ],
            );
          }
        },
      ),
      const SizedBox(height: 10),
      Text(S.of(context).solarPowerChartSubLegendPriceAndFee(Operating.chargePerValueConsumedPower.toStringAsFixed(2),
          Operating.chargePerMonthConsumedPower.toStringAsFixed(2))),
    ]);
  }
}
