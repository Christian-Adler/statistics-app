import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/settings/device_storage_card.dart';
import '../widgets/settings/server_card.dart';
import '../widgets/statistics_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings_screen';
  static const title = 'Einstellungen';
  static const iconData = Icons.settings;

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        const Text(SettingsScreen.title),
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
