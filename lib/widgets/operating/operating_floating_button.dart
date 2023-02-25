import 'package:flutter/material.dart';

import '../../screens/operating/solar_power_add_value_screen.dart';
import '../../screens/operating/solar_power_screen.dart';
import '../expandable/expandable_fab.dart';

class OperatingFloatingButton extends StatelessWidget {
  const OperatingFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 100.0,
      maxAngle: 70,
      startAngle: 10,
      actions: [
        ActionButtonData(Icons.solar_power_outlined, () {
          var navigator = Navigator.of(context);
          if (SolarPowerScreen.routeName != ModalRoute.of(context)?.settings.name) {
            navigator.pushReplacementNamed(SolarPowerScreen.routeName);
          }
          navigator.pushNamed(SolarPowerAddValueScreen.routeName);
        }),
        ActionButtonData(Icons.power_outlined, () => null, autoClose: false),
      ],
    );
  }
}
