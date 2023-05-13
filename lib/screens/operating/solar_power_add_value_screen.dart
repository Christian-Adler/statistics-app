import 'package:flutter/material.dart';

import '../../models/navigation/screen_nav_info.dart';
import '../../utils/global_keys.dart';
import '../../widgets/statistics/operating/solar_power_add_value.dart';
import '../../widgets/statistics_app_bar.dart';

class SolarPowerAddValueScreen extends StatefulWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    'Solar Strom eintragen',
    Icons.add,
    '/solar_power/add',
    () => const SolarPowerAddValueScreen(),
  );

  const SolarPowerAddValueScreen({Key? key}) : super(key: key);

  @override
  State<SolarPowerAddValueScreen> createState() => _SolarPowerAddValueScreenState();
}

class _SolarPowerAddValueScreenState extends State<SolarPowerAddValueScreen> {
  void _saveHandler() {
    final currentState = GlobalKeys.solarPowerAddValueState.currentState;
    currentState?.saveForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        Text(SolarPowerAddValueScreen.screenNavInfo.title),
        context,
        actions: [IconButton(onPressed: _saveHandler, icon: const Icon(Icons.save))],
      ),
      body: SolarPowerAddValue(
        key: GlobalKeys.solarPowerAddValueState,
      ),
    );
  }
}
