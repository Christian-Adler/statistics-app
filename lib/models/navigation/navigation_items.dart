import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../screens/car/car_screen.dart';
import '../../screens/heart/heart_screen.dart';
import '../../screens/info_screen.dart';
import '../../screens/operating/operating_screen.dart';
import '../../screens/operating/solar_power_screen.dart';
import '../../screens/overview_screen.dart';
import '../../screens/settings_screen.dart';
import '../../utils/globals.dart';
import 'navigation_divider_large.dart';
import 'navigation_divider_small.dart';
import 'navigation_item.dart';
import 'navigation_item_base.dart';
import 'screen_nav_info.dart';

class NavigationItems {
  static final NavigationItem _logoutNavigationItem = NavigationItem(
    ScreenNavInfo(
      (context) => S.of(context).commonsLogout,
      Icons.exit_to_app,
      '/logout',
      () => Container(),
    ),
    onNavOverride: (context) => Globals.logout(context),
  );

  static final NavigationItem _overviewNavigationItem = NavigationItem(OverviewScreen.screenNavInfo);
  static final NavigationItem _operatingNavigationItem = NavigationItem(
    OperatingScreen.screenNavInfo,
  );
  static final NavigationItem _solarPowerNavigationItem = NavigationItem(
    SolarPowerScreen.screenNavInfo,
  );
  static final NavigationItem _carNavigationItem = NavigationItem(
    CarScreen.screenNavInfo,
  );
  static final NavigationItem _heartNavigationItem = NavigationItem(
    HeartScreen.screenNavInfo,
  );
  static final NavigationItem _settingsNavigationItem = NavigationItem(
    SettingsScreen.screenNavInfo,
  );
  static final NavigationItem _infoNavigationItem = NavigationItem(
    InfoScreen.screenNavInfo,
  );

  /// indexedStackElemente
  static final List<NavigationItem> mainNavigationItems = [
    _overviewNavigationItem,
    _operatingNavigationItem,
    _solarPowerNavigationItem,
    _carNavigationItem,
    _heartNavigationItem,
    _settingsNavigationItem,
    _infoNavigationItem,
  ];

  static int mainNavigationItemsIndexOf(ScreenNavInfo screenNavInfo) {
    return mainNavigationItems.indexWhere((element) => element.screenNavInfo == screenNavInfo);
  }

  static final List<NavigationItemBase> navigationMenuItems = [
    _overviewNavigationItem,
    NavigationDividerSmall(),
    _operatingNavigationItem,
    _solarPowerNavigationItem,
    _carNavigationItem,
    _heartNavigationItem,
    NavigationDividerSmall(),
    _settingsNavigationItem,
    _infoNavigationItem,
    NavigationDividerLarge(),
    _logoutNavigationItem,
  ];
  static final List<NavigationItem> navigationBarItems = [
    _overviewNavigationItem,
    _operatingNavigationItem,
    _solarPowerNavigationItem,
    _carNavigationItem,
    _heartNavigationItem,
  ];
  static final List<NavigationItemBase> navigationBarMenuItems = [
    _settingsNavigationItem,
    _infoNavigationItem,
    NavigationDividerSmall(),
    _logoutNavigationItem,
  ];
}
