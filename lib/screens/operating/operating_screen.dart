import 'package:flutter/material.dart';

import '../../models/navigation/screen_nav_info.dart';
import '../../widgets/add_value_floating_button.dart';
import '../../widgets/navigation/app_bottom_navigation_bar.dart';
import '../../widgets/navigation/app_drawer.dart';
import '../../widgets/responsive/screen_layout_builder.dart';
import '../../widgets/statistics/operating/operating_view.dart';
import '../../widgets/statistics_app_bar.dart';
import 'operating_add_value_screen.dart';

class OperatingScreen extends StatefulWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Nebenkosten', Icons.power_input_outlined, '/operating');

  const OperatingScreen({Key? key}) : super(key: key);

  @override
  State<OperatingScreen> createState() => _OperatingScreenState();
}

class _OperatingScreenState extends State<OperatingScreen> {
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
        Text(OperatingScreen.screenNavInfo.title),
        context,
        actions: [
          IconButton(
            onPressed: () => _toggleYearly(),
            tooltip: 'Zeige ${_showYearly ? 'Monatsansicht' : 'Jahresansicht'}',
            icon: Icon(_showYearly ? Icons.calendar_month_outlined : Icons.calendar_today_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(OperatingAddValueScreen.screenNavInfo.routeName),
            tooltip: OperatingAddValueScreen.screenNavInfo.title,
            icon: Icon(OperatingAddValueScreen.screenNavInfo.iconData),
          ),
        ],
      ),
      body: OperatingView(showYearly: _showYearly),
      drawerBuilder: () => const AppDrawer(),
      bottomNavigationBarBuilder: () => const AppBottomNavigationBar(),
      floatingActionButton: const AddValueFloatingButton(),
    );
  }
}
