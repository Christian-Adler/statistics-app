import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/app_info.dart';
import '../../providers/app_layout.dart';
import '../../utils/globals.dart';
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
      return Drawer(
        width: 56,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: SafeArea(
          child: Container(
            color: Theme.of(context).drawerTheme.backgroundColor,
            child: NavigationMenuVertical(showNavigationTitle),
          ),
        ),
      );
    }

    return Drawer(
      child: Column(
        children: [
          StatisticsAppBar(
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
                    Globals.logout(context);
                  },
                  icon: const Icon(Icons.exit_to_app))
            ],
          ),
          Expanded(
            child: NavigationMenuVertical(showNavigationTitle),
          ),
        ],
      ),
    );
  }
}
