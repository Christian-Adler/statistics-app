import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/providers/main_navigation.dart';

import '../screens/car/car_screen.dart';
import '../screens/heart/heart_screen.dart';
import '../screens/operating/operating_screen.dart';
import '../screens/operating/solar_power_screen.dart';
import '../utils/global_keys.dart';
import 'expandable/expandable_fab.dart';

class AddValueFloatingButton extends StatelessWidget {
  const AddValueFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainNavigation = Provider.of<MainNavigation>(context, listen: false);

    return ExpandableFab(
      distance: 100.0,
      maxAngle: 110,
      startAngle: -10,
      actions: [
        ActionButtonData(OperatingScreen.screenNavInfo.iconData, () async {
          mainNavigation.mainPageRoute = OperatingScreen.screenNavInfo.routeName;

          // kurz warten, damit der Screen auch wirklich schon da ist - ansonsten ist der currentState noch null
          await Future.delayed(const Duration(milliseconds: 10), () => true);

          if (context.mounted) {
            final currentState = GlobalKeys.operatingScreenState.currentState;
            currentState?.showAddValue(context);
          }
        }),
        ActionButtonData(SolarPowerScreen.screenNavInfo.iconData, () async {
          mainNavigation.mainPageRoute = SolarPowerScreen.screenNavInfo.routeName;

          // kurz warten, damit der Screen auch wirklich schon da ist - ansonsten ist der currentState noch null
          await Future.delayed(const Duration(milliseconds: 10), () => true);

          if (context.mounted) {
            final currentState = GlobalKeys.solarPowerScreenState.currentState;
            currentState?.showAddValue(context);
          }
        }),
        ActionButtonData(CarScreen.screenNavInfo.iconData, () async {
          mainNavigation.mainPageRoute = CarScreen.screenNavInfo.routeName;

          // kurz warten, damit der Screen auch wirklich schon da ist - ansonsten ist der currentState noch null
          await Future.delayed(const Duration(milliseconds: 10), () => true);

          if (context.mounted) {
            final currentState = GlobalKeys.carScreenState.currentState;
            currentState?.showAddValue(context);
          }
        }),
        ActionButtonData(HeartScreen.screenNavInfo.iconData, () async {
          mainNavigation.mainPageRoute = HeartScreen.screenNavInfo.routeName;

          // kurz warten, damit der Screen auch wirklich schon da ist - ansonsten ist der currentState noch null
          await Future.delayed(const Duration(milliseconds: 10), () => true);

          if (context.mounted) {
            final currentState = GlobalKeys.heartScreenState.currentState;
            currentState?.showAddValue(context);
          }
        }),
      ],
    );
  }
}
