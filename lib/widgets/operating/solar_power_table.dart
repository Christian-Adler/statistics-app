import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/providers/operating.dart';

import '../../utils/globals.dart';

class SolarPowerTable extends StatelessWidget {
  const SolarPowerTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final powerData = Provider.of<Operating>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Werte-Tabelle'),
        ...powerData.solarPowerItems
            .map((powerChartItem) => Text(
                '${Globals.getMonthShort(powerChartItem.month)} ${powerChartItem.year} : ${powerChartItem.value.toDouble()}'))
            .toList(),
      ],
    );
  }
}
