import 'package:flutter/material.dart';

import '../screens/car/car_screen.dart';
import '../screens/heart/heart_screen.dart';
import '../screens/operating/operating_screen.dart';
import '../screens/operating/solar_power_screen.dart';
import '../widgets/statistics/car/car_add_value.dart';
import '../widgets/statistics/heart/heart_add_value.dart';
import '../widgets/statistics/operating/operating_add_value.dart';
import '../widgets/statistics/operating/solar_power_add_value.dart';

/// Menge von GlobalKey-Instanzen<br>
/// Fuer Zugriff von Aussen auf State um z.B. Aktion aufzurufen
class GlobalKeys {
  static final overviewScreenNavigatorKey = GlobalKey<NavigatorState>();

  static final heartScreenState = GlobalKey<HeartScreenState>();
  static final heartScreenNavigatorKey = GlobalKey<NavigatorState>();
  static final heartAddValueState = GlobalKey<HeartAddValueState>();

  static final carScreenState = GlobalKey<CarScreenState>();
  static final carScreenNavigatorKey = GlobalKey<NavigatorState>();
  static final carAddValueState = GlobalKey<CarAddValueState>();

  static final operatingScreenState = GlobalKey<OperatingScreenState>();
  static final operatingScreenNavigatorKey = GlobalKey<NavigatorState>();
  static final operatingAddValueState = GlobalKey<OperatingAddValueState>();

  static final solarPowerScreenState = GlobalKey<SolarPowerScreenState>();
  static final solarPowerScreenNavigatorKey = GlobalKey<NavigatorState>();
  static final solarPowerAddValueState = GlobalKey<SolarPowerAddValueState>();

  static final settingsScreenNavigatorKey = GlobalKey<NavigatorState>();
  static final infoScreenNavigatorKey = GlobalKey<NavigatorState>();
}
