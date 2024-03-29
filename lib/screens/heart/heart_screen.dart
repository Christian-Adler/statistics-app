import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:flutter_commons/utils/nav/navigation_utils.dart';
import 'package:flutter_commons/widgets/responsive/screen_layout_builder.dart';

import '../../generated/l10n.dart';
import '../../models/navigation/screen_nav_info.dart';
import '../../utils/global_keys.dart';
import '../../widgets/navigation/app_drawer.dart';
import '../../widgets/statistics/heart/heart_add_value.dart';
import '../../widgets/statistics/heart/heart_view.dart';
import '../../widgets/statistics_app_bar.dart';
import 'heart_add_value_screen.dart';

class HeartScreen extends StatefulWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleHeart,
    Icons.monitor_heart_outlined,
    '/heart',
    () => HeartScreen(key: GlobalKeys.heartScreenState),
    screensNestedNavigatorKey: GlobalKeys.heartScreenNavigatorKey,
  );

  const HeartScreen({Key? key}) : super(key: key);

  @override
  State<HeartScreen> createState() => HeartScreenState();
}

class HeartScreenState extends State<HeartScreen> {
  void _saveHandler() {
    final currentState = GlobalKeys.heartAddValueState.currentState;
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
              title: Text(HeartAddValueScreen.screenNavInfo.titleBuilder(ctx)),
              content: HeartAddValue(key: GlobalKeys.heartAddValueState),
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
      NavigationUtils.push(context, HeartAddValueScreen.screenNavInfo.createScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      createNestedNavigatorWithKey: HeartScreen.screenNavInfo.screensNestedNavigatorKey,
      appBarBuilder: (ctx) => StatisticsAppBar(
        Text(HeartScreen.screenNavInfo.titleBuilder(ctx)),
        ctx,
        actions: [
          IconButton(
            onPressed: () => showAddValue(ctx),
            tooltip: HeartAddValueScreen.screenNavInfo.titleBuilder(ctx),
            icon: Icon(HeartAddValueScreen.screenNavInfo.iconData),
          ),
        ],
      ),
      bodyBuilder: (ctx) => const HeartView(),
      drawerBuilder: (ctx) => const AppDrawer(),
    );
  }
}
