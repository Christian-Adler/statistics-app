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
  static final heartScreenState = GlobalKey<HeartScreenState>();
  static final heartAddValueState = GlobalKey<HeartAddValueState>();

  static final carScreenState = GlobalKey<CarScreenState>();
  static final carAddValueState = GlobalKey<CarAddValueState>();

  static final operatingScreenState = GlobalKey<OperatingScreenState>();
  static final operatingAddValueState = GlobalKey<OperatingAddValueState>();

  static final solarPowerScreenState = GlobalKey<SolarPowerScreenState>();
  static final solarPowerAddValueState = GlobalKey<SolarPowerAddValueState>();
}
