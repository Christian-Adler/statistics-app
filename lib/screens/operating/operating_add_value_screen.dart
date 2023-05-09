import 'package:flutter/material.dart';

import '../../models/navigation/screen_nav_info.dart';
import '../../utils/global_keys.dart';
import '../../widgets/statistics/operating/operating_add_value.dart';
import '../../widgets/statistics_app_bar.dart';

class OperatingAddValueScreen extends StatefulWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Betriebskosten eintragen', Icons.add, '/operating/add');

  const OperatingAddValueScreen({Key? key}) : super(key: key);

  @override
  State<OperatingAddValueScreen> createState() => _OperatingAddValueScreenState();
}

class _OperatingAddValueScreenState extends State<OperatingAddValueScreen> {
  void _saveHandler() {
    final currentState = GlobalKeys.operatingAddValueState.currentState;
    currentState?.saveForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        Text(OperatingAddValueScreen.screenNavInfo.title),
        context,
        actions: [IconButton(onPressed: _saveHandler, icon: const Icon(Icons.save))],
      ),
      body: OperatingAddValue(
        key: GlobalKeys.operatingAddValueState,
      ),
    );
  }
}
