import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/settings/animation_test_card.dart';
import '../widgets/settings/device_storage_card.dart';
import '../widgets/statistics_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings_screen';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        const Text('Settings'),
        context,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            DeviceStorageCard(),
            AnimationTestCard(),
          ],
        ),
      ),
    );
  }
}
