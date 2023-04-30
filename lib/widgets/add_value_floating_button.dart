import 'package:flutter/material.dart';

import '../screens/car/car_add_value_screen.dart';
import '../screens/car/car_screen.dart';
import '../screens/heart/heart_add_value_screen.dart';
import '../screens/heart/heart_screen.dart';
import '../screens/operating/operating_add_value_screen.dart';
import '../screens/operating/operating_screen.dart';
import '../screens/operating/solar_power_add_value_screen.dart';
import '../screens/operating/solar_power_screen.dart';
import '../utils/nav/navigation_utils.dart';
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
        ActionButtonData(OperatingScreen.screenNavInfo.iconData, () {
          NavigationUtils.navigateToRoute(context, navigator,
              [OperatingScreen.screenNavInfo.routeName, OperatingAddValueScreen.screenNavInfo.routeName]);
        }),
        ActionButtonData(SolarPowerScreen.screenNavInfo.iconData, () {
          NavigationUtils.navigateToRoute(context, navigator,
              [SolarPowerScreen.screenNavInfo.routeName, SolarPowerAddValueScreen.screenNavInfo.routeName]);
        }),
        ActionButtonData(CarScreen.screenNavInfo.iconData, () {
          NavigationUtils.navigateToRoute(
              context, navigator, [CarScreen.screenNavInfo.routeName, CarAddValueScreen.screenNavInfo.routeName]);
        }),
        ActionButtonData(HeartScreen.screenNavInfo.iconData, () {
          NavigationUtils.navigateToRoute(
              context, navigator, [HeartScreen.screenNavInfo.routeName, HeartAddValueScreen.screenNavInfo.routeName]);
        }),
      ],
    );
  }
}
