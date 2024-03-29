import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:flutter_commons/utils/nav/navigation_utils.dart';
import 'package:flutter_commons/widgets/responsive/screen_layout_builder.dart';

import '../../generated/l10n.dart';
import '../../models/navigation/screen_nav_info.dart';
import '../../utils/global_keys.dart';
import '../../widgets/navigation/app_drawer.dart';
import '../../widgets/statistics/operating/solar_power_add_value.dart';
import '../../widgets/statistics/operating/solar_power_view.dart';
import '../../widgets/statistics_app_bar.dart';
import 'solar_power_add_value_screen.dart';

class SolarPowerScreen extends StatefulWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleSolarPower,
    Icons.solar_power_outlined,
    '/solar_power',
    () => SolarPowerScreen(key: GlobalKeys.solarPowerScreenState),
    screensNestedNavigatorKey: GlobalKeys.solarPowerScreenNavigatorKey,
  );

  const SolarPowerScreen({Key? key}) : super(key: key);

  @override
  State<SolarPowerScreen> createState() => SolarPowerScreenState();
}

class SolarPowerScreenState extends State<SolarPowerScreen> {
  bool _showYearly = false;

  void _toggleYearly() {
    setState(() {
      _showYearly = !_showYearly;
    });
  }

  void _saveHandler() {
    final currentState = GlobalKeys.solarPowerAddValueState.currentState;
    currentState?.saveForm();
  }

  /// Ruft je nach Device addValue in neuem Screen auf im Dialog
  void showAddValue(BuildContext context) {
    final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));

    if (mediaQueryInfo.isTablet && mediaQueryInfo.isPortrait) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(SolarPowerAddValueScreen.screenNavInfo.titleBuilder(ctx)),
              content: SolarPowerAddValue(key: GlobalKeys.solarPowerAddValueState),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text(S.of(context).commonsDialogBtnCancel)),
                TextButton(
                  onPressed: () {
                    _saveHandler(); // SaveHandler macht bei Erfolg selbst pop
                  },
                  child: Text(S.of(context).commonsDialogBtnSave),
                )
              ],
            );
          });
    } else {
      NavigationUtils.push(context, SolarPowerAddValueScreen.screenNavInfo.createScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      createNestedNavigatorWithKey: SolarPowerScreen.screenNavInfo.screensNestedNavigatorKey,
      appBarBuilder: (ctx) => StatisticsAppBar(
        Text(SolarPowerScreen.screenNavInfo.titleBuilder(ctx)),
        ctx,
        actions: [
          IconButton(
            onPressed: () => _toggleYearly(),
            icon: Icon(_showYearly ? Icons.calendar_month_outlined : Icons.calendar_today_outlined),
          ),
          IconButton(
            onPressed: () => showAddValue(ctx),
            tooltip: SolarPowerAddValueScreen.screenNavInfo.titleBuilder(ctx),
            icon: Icon(SolarPowerAddValueScreen.screenNavInfo.iconData),
          ),
        ],
      ),
      bodyBuilder: (ctx) => SolarPowerView(showYearly: _showYearly),
      drawerBuilder: (ctx) => const AppDrawer(),
    );
  }
}
