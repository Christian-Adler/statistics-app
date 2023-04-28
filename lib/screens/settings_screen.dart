import 'package:flutter/material.dart';
import 'package:statistics/widgets/settings/app_layout_settings_card.dart';

import '../models/screen_nav_info.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/settings/device_storage_card.dart';
import '../widgets/settings/server_card.dart';
import '../widgets/statistics_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Einstellungen', Icons.settings, '/settings_screen');

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        Text(SettingsScreen.screenNavInfo.title),
        context,
      ),
      drawer: const AppDrawer(),
      body: Scrollbar(
        child: SingleChildScrollView(
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
      ),
    );
  }
}
