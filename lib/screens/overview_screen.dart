import 'package:flutter/material.dart';

import '../models/navigation/screen_nav_info.dart';
import '../utils/global_keys.dart';
import '../widgets/logo/eagle_logo.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/overview/overview.dart';
import '../widgets/responsive/screen_layout_builder.dart';
import '../widgets/statistics_app_bar.dart';

class OverviewScreen extends StatelessWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    'Übersicht',
    Icons.home_outlined,
    '/overview',
    () => const OverviewScreen(),
    screensNestedNavigatorKey: GlobalKeys.overviewScreenNavigatorKey,
  );

  const OverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      createNestedNavigatorWithKey: OverviewScreen.screenNavInfo.screensNestedNavigatorKey,
      appBarBuilder: (ctx) => StatisticsAppBar(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(OverviewScreen.screenNavInfo.title),
            const EagleLogo(),
          ],
        ),
        ctx,
      ),
      bodyBuilder: (ctx) => const Overview(),
      drawerBuilder: (ctx) => const AppDrawer(),
    );
  }
}
