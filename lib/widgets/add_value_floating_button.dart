import 'package:flutter/material.dart';

import '../screens/car/car_add_value_screen.dart';
import '../screens/car/car_screen.dart';
import '../screens/heart/heart_add_value_screen.dart';
import '../screens/heart/heart_screen.dart';
import '../screens/operating/operating_add_value_screen.dart';
import '../screens/operating/operating_screen.dart';
import '../screens/operating/solar_power_screen.dart';
import '../utils/navigation_utils.dart';
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
        ActionButtonData(OperatingScreen.iconData, () {
          NavigationUtils.navigateToRoute(
              context, navigator, [OperatingScreen.routeName, OperatingAddValueScreen.routeName]);
        }),
        ActionButtonData(SolarPowerScreen.iconData, () {
          NavigationUtils.navigateToRoute(context, navigator, [SolarPowerScreen.routeName, SolarPowerScreen.routeName]);
        }),
        ActionButtonData(CarScreen.iconData, () {
          NavigationUtils.navigateToRoute(context, navigator, [CarScreen.routeName, CarAddValueScreen.routeName]);
        }),
        ActionButtonData(HeartScreen.iconData, () {
          NavigationUtils.navigateToRoute(context, navigator, [HeartScreen.routeName, HeartAddValueScreen.routeName]);
        }),
      ],
    );
  }
}
