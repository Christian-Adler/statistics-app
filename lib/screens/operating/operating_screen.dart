import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:flutter_commons/widgets/responsive/screen_layout_builder.dart';

import '../../generated/l10n.dart';
import '../../models/navigation/screen_nav_info.dart';
import '../../utils/global_keys.dart';
import '../../utils/nav/navigation_utils.dart';
import '../../widgets/navigation/app_drawer.dart';
import '../../widgets/statistics/operating/operating_add_value.dart';
import '../../widgets/statistics/operating/operating_view.dart';
import '../../widgets/statistics_app_bar.dart';
import 'operating_add_value_screen.dart';

class OperatingScreen extends StatefulWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleOperating,
    Icons.power_input_outlined,
    '/operating',
    () => OperatingScreen(key: GlobalKeys.operatingScreenState),
    screensNestedNavigatorKey: GlobalKeys.operatingScreenNavigatorKey,
  );

  const OperatingScreen({Key? key}) : super(key: key);

  @override
  State<OperatingScreen> createState() => OperatingScreenState();
}

class OperatingScreenState extends State<OperatingScreen> {
  bool _showYearly = false;

  void _toggleYearly() {
    setState(() {
      _showYearly = !_showYearly;
    });
  }

  void _saveHandler() {
    final currentState = GlobalKeys.operatingAddValueState.currentState;
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
              title: Text(OperatingAddValueScreen.screenNavInfo.titleBuilder(ctx)),
              content: OperatingAddValue(key: GlobalKeys.operatingAddValueState),
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
      NavigationUtils.push(context, OperatingAddValueScreen.screenNavInfo.createScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      createNestedNavigatorWithKey: OperatingScreen.screenNavInfo.screensNestedNavigatorKey,
      appBarBuilder: (ctx) => StatisticsAppBar(
        Text(OperatingScreen.screenNavInfo.titleBuilder(ctx)),
        ctx,
        actions: [
          IconButton(
            onPressed: () => _toggleYearly(),
            icon: Icon(_showYearly ? Icons.calendar_month_outlined : Icons.calendar_today_outlined),
          ),
          IconButton(
            onPressed: () => showAddValue(ctx),
            tooltip: OperatingAddValueScreen.screenNavInfo.titleBuilder(ctx),
            icon: Icon(OperatingAddValueScreen.screenNavInfo.iconData),
          ),
        ],
      ),
      bodyBuilder: (ctx) => OperatingView(showYearly: _showYearly),
      drawerBuilder: (ctx) => const AppDrawer(),
    );
  }
}
