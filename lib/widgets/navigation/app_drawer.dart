import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_commons/utils/nav/navigation_utils.dart';
import 'package:provider/provider.dart';

import '../../providers/app_layout.dart';
import '../../utils/color_utils.dart';
import '../../utils/global_settings.dart';
import '../logo/eagle_logo.dart';
import '../statistics_app_bar.dart';
import 'navigation_menu_vertical.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLayout = Provider.of<AppLayout>(context);
    final showNavigationTitle = appLayout.showNavigationItemTitle;

    if (!showNavigationTitle) {
      return _buildDrawerWithNoTitles(context);
    }

    final statisticsAppBarWithTitles = StatisticsAppBar(
      Row(
        children: [
          const EagleLogo(),
          const SizedBox(width: 10),
          Text(AppInfo.appName),
        ],
      ),
      context,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
            onPressed: () {
              // Globals.logout(context);
              NavigationUtils.closeDrawerIfOpen(context);
            },
            // icon: const Icon(Icons.exit_to_app))
            icon: const Icon(Icons.close))
      ],
      actionsColor: ColorUtils.getThemeOnGradientColor(context),
    );

    GlobalSettings.appBarHeight = statisticsAppBarWithTitles.preferredSize.height;

    return Drawer(
      child: Column(
        children: [
          statisticsAppBarWithTitles,
          Expanded(
            child: NavigationMenuVertical(showNavigationTitle),
          ),
        ],
      ),
    );
  }

  Drawer _buildDrawerWithNoTitles(BuildContext context) {
    final statisticsAppBarNoTitles = StatisticsAppBar(
      IconButton(
        icon: const Icon(Icons.close),
        padding: EdgeInsets.zero,
        alignment: Alignment.centerLeft,
        onPressed: () {
          NavigationUtils.closeDrawerIfOpen(context);
        },
      ),
      context,
      automaticallyImplyLeading: false,
    );

    GlobalSettings.appBarHeight = statisticsAppBarNoTitles.preferredSize.height;

    return Drawer(
      width: 56,
      child: Column(
        children: [
          statisticsAppBarNoTitles,
          const Expanded(
            child: NavigationMenuVertical(false),
          ),
        ],
      ),
    );
  }
}
