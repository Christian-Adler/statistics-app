import 'package:flutter/material.dart';

import '../screens/car/car_add_value_screen.dart';
import '../screens/car/car_screen.dart';
import '../screens/heart/heart_add_value_screen.dart';
import '../screens/heart/heart_screen.dart';
import '../screens/operating/operating_add_value_screen.dart';
import '../screens/operating/operating_screen.dart';
import '../screens/operating/solar_power_add_value_screen.dart';
import '../screens/operating/solar_power_screen.dart';
import 'expandable/expandable_fab.dart';

class AddValueFloatingButton extends StatelessWidget {
  const AddValueFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    return ExpandableFab(
      distance: 100.0,
      maxAngle: 110,
      startAngle: -10,
      actions: [
        ActionButtonData(Icons.solar_power_outlined, () {
          if (SolarPowerScreen.routeName != ModalRoute.of(context)?.settings.name) {
            navigator.pushReplacementNamed(SolarPowerScreen.routeName);
          }
          navigator.pushNamed(SolarPowerAddValueScreen.routeName);
        }),
        ActionButtonData(Icons.power_input_outlined, () {
          if (OperatingScreen.routeName != ModalRoute.of(context)?.settings.name) {
            navigator.pushReplacementNamed(OperatingScreen.routeName);
          }
          navigator.pushNamed(OperatingAddValueScreen.routeName);
        }),
        ActionButtonData(Icons.directions_car_outlined, () {
          if (CarScreen.routeName != ModalRoute.of(context)?.settings.name) {
            navigator.pushReplacementNamed(CarScreen.routeName);
          }
          navigator.pushNamed(CarAddValueScreen.routeName);
        }),
        ActionButtonData(Icons.monitor_heart_outlined, () {
          if (HeartScreen.routeName != ModalRoute.of(context)?.settings.name) {
            navigator.pushReplacementNamed(HeartScreen.routeName);
          }
          navigator.pushNamed(HeartAddValueScreen.routeName);
        }),
      ],
    );
  }
}
