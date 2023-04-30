import 'package:flutter/material.dart';

import '../models/navigation/screen_nav_info.dart';
import '../widgets/navigation/app_bottom_navigation_bar.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/responsive/screen_layout_builder.dart';
import '../widgets/settings/app_layout_settings_card.dart';
import '../widgets/settings/device_storage_card.dart';
import '../widgets/settings/server_card.dart';
import '../widgets/statistics_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Einstellungen', Icons.settings, '/settings_screen');

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      appBar: StatisticsAppBar(
        Text(SettingsScreen.screenNavInfo.title),
        context,
      ),
      body: _SettingsScreenBody(),
      drawerBuilder: () => const AppDrawer(),
      bottomNavigationBarBuilder: () => const AppBottomNavigationBar(),
    );
  }
}

class _SettingsScreenBody extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  _SettingsScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
