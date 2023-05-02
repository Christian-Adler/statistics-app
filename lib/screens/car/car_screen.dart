import 'package:flutter/material.dart';

import '../../models/navigation/screen_nav_info.dart';
import '../../widgets/add_value_floating_button.dart';
import '../../widgets/navigation/app_bottom_navigation_bar.dart';
import '../../widgets/navigation/app_drawer.dart';
import '../../widgets/responsive/screen_layout_builder.dart';
import '../../widgets/statistics/car/car_view.dart';
import '../../widgets/statistics_app_bar.dart';
import 'car_add_value_screen.dart';

class CarScreen extends StatelessWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Tanken', Icons.directions_car_outlined, '/car');

  const CarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      appBar: StatisticsAppBar(
        Text(CarScreen.screenNavInfo.title),
        context,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(CarAddValueScreen.screenNavInfo.routeName),
            tooltip: CarAddValueScreen.screenNavInfo.title,
            icon: Icon(CarAddValueScreen.screenNavInfo.iconData),
          ),
        ],
      ),
      body: const CarView(),
      drawerBuilder: () => const AppDrawer(),
      bottomNavigationBarBuilder: () => const AppBottomNavigationBar(),
      floatingActionButton: const AddValueFloatingButton(),
    );
  }
}
