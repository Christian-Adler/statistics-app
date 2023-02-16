import 'package:flutter/material.dart';

import '../../screens/operating/insert_solar_power_value_screen.dart';
import '../../screens/operating/solar_power_chart_screen.dart';
import '../expandable/expandable_fab.dart';

class OperatingFloatingButton extends StatelessWidget {
  const OperatingFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 100.0,
      maxAngle: 70,
      startAngle: 10,
      children: [
        ActionButton(
          onPressed: () {
            var navigator = Navigator.of(context);
            if (SolarPowerChartScreen.routeName != ModalRoute.of(context)?.settings.name) {
              navigator.pushReplacementNamed(SolarPowerChartScreen.routeName);
            }
            navigator.pushNamed(InsertSolarPowerValueScreen.routeName);
          },
          icon: const Icon(Icons.solar_power_outlined),
        ),
        ActionButton(
          onPressed: () {},
          icon: const Icon(Icons.power_input_outlined),
        ),
      ],
    );
  }
}
