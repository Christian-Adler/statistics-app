import 'package:flutter/material.dart';
import 'package:flutter_commons/widgets/responsive/screen_layout_builder.dart';

import '../generated/l10n.dart';
import '../models/navigation/screen_nav_info.dart';
import '../utils/global_keys.dart';
import '../widgets/logo/eagle_logo.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/overview/overview.dart';
import '../widgets/statistics_app_bar.dart';

class OverviewScreen extends StatelessWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleOverview,
    Icons.home_outlined,
    '/overview',
    () => const OverviewScreen(),
    screensNestedNavigatorKey: GlobalKeys.overviewScreenNavigatorKey,
    disposeIfNotVisible: true,
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
            Text(OverviewScreen.screenNavInfo.titleBuilder(ctx)),
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
