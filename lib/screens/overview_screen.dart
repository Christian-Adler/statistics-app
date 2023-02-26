import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/operating/operating_floating_button.dart';
import '../widgets/statistics_app_bar.dart';

class OverviewScreen extends StatelessWidget {
  static const String routeName = '/overview';

  const OverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        const Text('Overview'),
        context,
      ),
      drawer: const AppDrawer(),
      body: const Text('TODO'),
      floatingActionButton: const OperatingFloatingButton(),
    );
  }
}
