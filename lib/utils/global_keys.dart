import 'package:flutter/material.dart';

import '../screens/heart/heart_screen.dart';
import '../widgets/add_value/heart_add_value.dart';

/// Menge von GlobalKey-Instanzen<br>
/// Fuer Zugriff von Aussen auf State um z.B. Aktion aufzurufen
class GlobalKeys {
  static final heartScreenState = GlobalKey<HeartScreenState>();
  static final heartAddValueState = GlobalKey<HeartAddValueState>();
}
