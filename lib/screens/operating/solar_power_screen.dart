import 'package:flutter/material.dart';

import '../../models/navigation/screen_nav_info.dart';
import '../../widgets/add_value_floating_button.dart';
import '../../widgets/navigation/app_bottom_navigation_bar.dart';
import '../../widgets/navigation/app_drawer.dart';
import '../../widgets/responsive/screen_layout_builder.dart';
import '../../widgets/statistics/operating/solar_power_view.dart';
import '../../widgets/statistics_app_bar.dart';
import 'solar_power_add_value_screen.dart';

class SolarPowerScreen extends StatefulWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Solar-Strom', Icons.solar_power_outlined, '/solar_power');

  const SolarPowerScreen({Key? key}) : super(key: key);

  @override
  State<SolarPowerScreen> createState() => _SolarPowerScreenState();
}

class _SolarPowerScreenState extends State<SolarPowerScreen> {
  bool _showYearly = false;

  void _toggleYearly() {
    setState(() {
      _showYearly = !_showYearly;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      appBar: StatisticsAppBar(
        Text(SolarPowerScreen.screenNavInfo.title),
        context,
        actions: [
          IconButton(
            onPressed: () => _toggleYearly(),
            tooltip: 'Zeige ${_showYearly ? 'Monatsansicht' : 'Jahresansicht'}',
            icon: Icon(_showYearly ? Icons.calendar_month_outlined : Icons.calendar_today_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(SolarPowerAddValueScreen.screenNavInfo.routeName),
            tooltip: SolarPowerAddValueScreen.screenNavInfo.title,
            icon: Icon(SolarPowerAddValueScreen.screenNavInfo.iconData),
          ),
        ],
      ),
      body: SolarPowerView(showYearly: _showYearly),
      drawerBuilder: () => const AppDrawer(),
      bottomNavigationBarBuilder: () => const AppBottomNavigationBar(),
      floatingActionButton: const AddValueFloatingButton(),
    );
  }
}
