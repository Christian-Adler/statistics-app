import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/table_utils.dart';
import 'package:flutter_commons/widgets/responsive/device_dependent_constrained_box.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../providers/operating.dart';
import '../../../../utils/date_utils.dart';

class SolarPowerTable extends StatelessWidget {
  final bool showYearly;

  const SolarPowerTable(this.showYearly, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final powerData = Provider.of<Operating>(context);
    final deviceSize = MediaQuery.of(context).size;

    Widget buildValueTable() {
      List<TableRow> rows = [
        TableUtils.tableHeadline(
            S.of(context).solarPowerTableHeadDate,
            deviceSize.width < 400
                ? [
                    S.of(context).solarPowerTableHeadGeneratedAbbrev,
                    S.of(context).solarPowerTableHeadFedAbbrev,
                    S.of(context).solarPowerTableHeadConsumptionAbbrev,
                    S.of(context).solarPowerTableHeadTotalAbbrev
                  ]
                : [
                    S.of(context).solarPowerTableHeadGenerated,
                    S.of(context).solarPowerTableHeadFed,
                    S.of(context).solarPowerTableHeadConsumption,
                    S.of(context).solarPowerTableHeadTotal
                  ])
      ];

      final operatingItems = showYearly ? powerData.operatingItemsYearly : powerData.operatingItems;

      rows.addAll(operatingItems.reversed
          .map((powerChartItem) => TableUtils.tableRow(
                showYearly
                    ? powerChartItem.year.toString()
                    : '${DateUtil.getMonthShort(powerChartItem.month)}${powerChartItem.month == 1 ? ' (${powerChartItem.year})' : ''}    ',
                [
                  powerChartItem.generatedPower,
                  powerChartItem.feedPower,
                  powerChartItem.consumedPower,
                  powerChartItem.totalUsedPower
                ],
              ))
          .toList());

      return Table(
        // https://api.flutter.dev/flutter/widgets/Table-class.html
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(60), // IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
          4: FlexColumnWidth(),
        },
        border: TableBorder.symmetric(
          inside: BorderSide(
            width: 1,
            color: Theme.of(context).indicatorColor.withOpacity(0.2),
          ),
        ),
        children: rows,
      );
    }

    return DeviceDependentWidthConstrainedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildValueTable(),
        ],
      ),
    );
  }
}
