import 'package:flutter/material.dart';

import '../models/navigation/screen_nav_info.dart';
import '../widgets/layout/single_child_scroll_view_with_scrollbar.dart';
import '../widgets/navigation/app_bottom_navigation_bar.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/responsive/screen_layout_builder.dart';
import '../widgets/settings/app_layout_settings_card.dart';
import '../widgets/settings/device_storage_card.dart';
import '../widgets/settings/server_card.dart';
import '../widgets/statistics_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    'Einstellungen',
    Icons.settings,
    '/settings_screen',
    () => const SettingsScreen(),
  );

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      appBar: StatisticsAppBar(
        Text(SettingsScreen.screenNavInfo.title),
        context,
      ),
      body: const _SettingsScreenBody(),
      drawerBuilder: () => const AppDrawer(),
      bottomNavigationBarBuilder: () => const AppBottomNavigationBar(),
    );
  }
}

class _SettingsScreenBody extends StatelessWidget {
  const _SettingsScreenBody();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollViewWithScrollbar(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            AppLayoutSettingsCard(),
            ServerCard(),
            DeviceStorageCard(),
            // AnimationTestCard(),
          ],
        ),
      ),
    );
  }
}
