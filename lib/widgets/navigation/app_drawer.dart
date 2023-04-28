import 'package:flutter/material.dart';
import 'package:statistics/widgets/logo/eagle_logo.dart';

import '../../utils/globals.dart';
import '../statistics_app_bar.dart';
import 'navigation_menu_vertical.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          StatisticsAppBar(
            Row(
              children: const [
                EagleLogo(),
                SizedBox(width: 10),
                Text('Statistics'),
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
          const Expanded(
            child: NavigationMenuVertical(),
          ),
        ],
      ),
    );
  }
}
