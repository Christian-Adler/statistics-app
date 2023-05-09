import 'package:flutter/material.dart';

import '../../models/navigation/screen_nav_info.dart';
import '../../utils/global_keys.dart';
import '../../widgets/statistics/car/car_add_value.dart';
import '../../widgets/statistics_app_bar.dart';

class CarAddValueScreen extends StatefulWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Tanken eintragen', Icons.add, '/car/add');

  const CarAddValueScreen({Key? key}) : super(key: key);

  @override
  State<CarAddValueScreen> createState() => _CarAddValueScreenState();
}

class _CarAddValueScreenState extends State<CarAddValueScreen> {
  void _saveHandler() {
    final currentState = GlobalKeys.carAddValueState.currentState;
    currentState?.saveForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        Text(CarAddValueScreen.screenNavInfo.title),
        context,
        actions: [IconButton(onPressed: _saveHandler, icon: const Icon(Icons.save))],
      ),
      body: CarAddValue(
        key: GlobalKeys.carAddValueState,
      ),
    );
  }
}
