import 'package:flutter/material.dart';

import '../../screens/car/car_screen.dart';
import '../../screens/heart/heart_screen.dart';
import '../../screens/info_screen.dart';
import '../../screens/operating/operating_screen.dart';
import '../../screens/operating/solar_power_screen.dart';
import '../../screens/overview_screen.dart';
import '../../screens/settings_screen.dart';
import '../../utils/globals.dart';
import '../../utils/nav/navigation_utils.dart';
import 'navigation_divider_large.dart';
import 'navigation_divider_small.dart';
import 'navigation_item.dart';
import 'navigation_item_base.dart';
import 'screen_nav_info.dart';

class NavigationItems {
  static final List<NavigationItemBase> navigationMenuItems = [
    NavigationItem(
        OverviewScreen.screenNavInfo, (context, navigator) => NavigationUtils.navigateToRoute(context, navigator, [])),
    NavigationDividerSmall(),
    NavigationItem(
        OperatingScreen.screenNavInfo,
        (context, navigator) =>
            NavigationUtils.navigateToRoute(context, navigator, [OperatingScreen.screenNavInfo.routeName])),
    NavigationDividerSmall(),
    NavigationItem(
        SolarPowerScreen.screenNavInfo,
        (context, navigator) =>
            NavigationUtils.navigateToRoute(context, navigator, [SolarPowerScreen.screenNavInfo.routeName])),
    NavigationDividerSmall(),
    NavigationItem(
        CarScreen.screenNavInfo,
        (context, navigator) =>
            NavigationUtils.navigateToRoute(context, navigator, [CarScreen.screenNavInfo.routeName])),
    NavigationDividerSmall(),
    NavigationItem(
        HeartScreen.screenNavInfo,
        (context, navigator) =>
            NavigationUtils.navigateToRoute(context, navigator, [HeartScreen.screenNavInfo.routeName])),
    NavigationDividerLarge(),
    NavigationItem(
        SettingsScreen.screenNavInfo,
        (context, navigator) =>
            NavigationUtils.navigateToRoute(context, navigator, [SettingsScreen.screenNavInfo.routeName])),
    NavigationDividerSmall(),
    NavigationItem(
        InfoScreen.screenNavInfo,
        (context, navigator) =>
            NavigationUtils.navigateToRoute(context, navigator, [InfoScreen.screenNavInfo.routeName])),
    NavigationDividerLarge(),
    NavigationItem(
      const ScreenNavInfo('Logout', Icons.exit_to_app, '/logout'),
      (context, navigator) => Globals.logout(context),
    ),
  ];
  static final List<NavigationItem> navigationBarItems = [
    NavigationItem(
        OverviewScreen.screenNavInfo, (context, navigator) => NavigationUtils.navigateToRoute(context, navigator, [])),
    NavigationItem(
        OperatingScreen.screenNavInfo,
        (context, navigator) =>
            NavigationUtils.navigateToRoute(context, navigator, [OperatingScreen.screenNavInfo.routeName])),
    NavigationItem(
        SolarPowerScreen.screenNavInfo,
        (context, navigator) =>
            NavigationUtils.navigateToRoute(context, navigator, [SolarPowerScreen.screenNavInfo.routeName])),
    NavigationItem(
        CarScreen.screenNavInfo,
        (context, navigator) =>
            NavigationUtils.navigateToRoute(context, navigator, [CarScreen.screenNavInfo.routeName])),
    NavigationItem(
        HeartScreen.screenNavInfo,
        (context, navigator) =>
            NavigationUtils.navigateToRoute(context, navigator, [HeartScreen.screenNavInfo.routeName])),
  ];
}
