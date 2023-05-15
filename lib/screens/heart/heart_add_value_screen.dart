import 'package:flutter/material.dart';

import '../../models/navigation/screen_nav_info.dart';
import '../../utils/global_keys.dart';
import '../../widgets/statistics/heart/heart_add_value.dart';
import '../../widgets/statistics_app_bar.dart';

class HeartAddValueScreen extends StatefulWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    'Blutdruck eintragen',
    Icons.add,
    '/heart/add',
    () => const HeartAddValueScreen(),
  );

  const HeartAddValueScreen({Key? key}) : super(key: key);

  @override
  State<HeartAddValueScreen> createState() => _HeartAddValueScreenState();
}

class _HeartAddValueScreenState extends State<HeartAddValueScreen> {
  void _saveHandler() {
    final currentState = GlobalKeys.heartAddValueState.currentState;
    currentState?.saveForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        Text(HeartAddValueScreen.screenNavInfo.title),
        context,
        actions: [IconButton(onPressed: _saveHandler, icon: const Icon(Icons.save))],
      ),
      body: HeartAddValue(
        key: GlobalKeys.heartAddValueState,
      ),
    );
  }
}
