import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/providers/operating.dart';

import '../../utils/globals.dart';
import '../../utils/tables.dart';

class SolarPowerTable extends StatelessWidget {
  final bool showYearly;

  const SolarPowerTable(this.showYearly, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final powerData = Provider.of<Operating>(context);

    Widget buildValueTable() {
      List<TableRow> rows = [
        Tables.tableHeadline('Datum', ['Erzeugt', 'Eingespeist', 'Verbraucht', 'Gesamt'])
      ];

      final operatingItems = showYearly ? powerData.operatingItemsYearly : powerData.operatingItems;

      rows.addAll(operatingItems.reversed
          .map((powerChartItem) => Tables.tableRow(
                showYearly
                    ? powerChartItem.year.toString()
                    : '${Globals.getMonthShort(powerChartItem.month)}${powerChartItem.month == 1 ? ' (${powerChartItem.year})' : ''}    ',
                [
                  powerChartItem.generatedPower,
                  powerChartItem.feedPower,
                  powerChartItem.consumedPower,
                  powerChartItem.totalUsedPower
                ],
              ))
          .toList());

      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Table(
          // https://api.flutter.dev/flutter/widgets/Table-class.html
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(60), // IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
            3: FlexColumnWidth(),
            4: FlexColumnWidth(),
          },
          border: TableBorder.symmetric(
            inside: const BorderSide(width: 1, color: Colors.black12),
          ),
          children: rows,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildValueTable(),
      ],
    );
  }
}
