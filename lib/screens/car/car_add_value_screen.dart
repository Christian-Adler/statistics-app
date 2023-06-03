import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../models/navigation/screen_nav_info.dart';
import '../../utils/global_keys.dart';
import '../../widgets/statistics/car/car_add_value.dart';
import '../../widgets/statistics_app_bar.dart';

class CarAddValueScreen extends StatefulWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleCarAddValue,
    Icons.add,
    '/car/add',
    () => const CarAddValueScreen(),
  );

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
        Text(CarAddValueScreen.screenNavInfo.titleBuilder(context)),
        context,
        actions: [IconButton(onPressed: _saveHandler, icon: const Icon(Icons.save))],
      ),
      body: CarAddValue(
        key: GlobalKeys.carAddValueState,
      ),
    );
  }
}
