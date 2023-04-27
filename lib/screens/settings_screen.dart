import 'package:flutter/material.dart';

import '../models/screen_nav_info.dart';
import '../widgets/app_drawer.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ServerCard(),
            DeviceStorageCard(),
            // AnimationTestCard(),
          ],
        ),
      ),
    );
  }
}
