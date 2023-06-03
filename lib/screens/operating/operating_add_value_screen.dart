import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../models/navigation/screen_nav_info.dart';
import '../../utils/global_keys.dart';
import '../../widgets/statistics/operating/operating_add_value.dart';
import '../../widgets/statistics_app_bar.dart';

class OperatingAddValueScreen extends StatefulWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleOperatingAddValue,
    Icons.add,
    '/operating/add',
    () => const OperatingAddValueScreen(),
  );

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
        Text(OperatingAddValueScreen.screenNavInfo.titleBuilder(context)),
        context,
        actions: [IconButton(onPressed: _saveHandler, icon: const Icon(Icons.save))],
      ),
      body: OperatingAddValue(
        key: GlobalKeys.operatingAddValueState,
      ),
    );
  }
}
