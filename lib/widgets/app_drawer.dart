import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:statistics/screens/info_screen.dart';
import 'package:statistics/widgets/logo/eagle_logo.dart';

import '../screens/car/car_screen.dart';
import '../screens/heart/heart_screen.dart';
import '../screens/operating/operating_screen.dart';
import '../screens/operating/solar_power_screen.dart';
import '../screens/overview_screen.dart';
import '../screens/settings_screen.dart';
import '../utils/globals.dart';
import '../utils/navigation_utils.dart';
import 'statistics_app_bar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        StatisticsAppBar(
          Row(
            children: const [
              EagleLogo(),
              SizedBox(width: 10),
              Text('Statistics'),
            ],
          ),
          context,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Globals.logout(context);
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Image.asset(
                        Globals.assetImgBackground,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const _MenuItemsScrollView(),
            ],
          ),
        ),
      ]),
    );
  }
}

class _MenuItemsScrollView extends StatelessWidget {
  const _MenuItemsScrollView();

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    return SingleChildScrollView(
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            // delay: const Duration(milliseconds: 10),
            duration: const Duration(milliseconds: 175),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              ListTile(
                title: const Text(OverviewScreen.title),
                leading: const Icon(OverviewScreen.iconData),
                onTap: () {
                  NavigationUtils.navigateToRoute(context, navigator, []);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(OperatingScreen.title),
                leading: const Icon(OperatingScreen.iconData),
                onTap: () {
                  NavigationUtils.navigateToRoute(context, navigator, [OperatingScreen.routeName]);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(SolarPowerScreen.title),
                leading: const Icon(SolarPowerScreen.iconData),
                onTap: () {
                  NavigationUtils.navigateToRoute(context, navigator, [SolarPowerScreen.routeName]);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(CarScreen.title),
                leading: const Icon(CarScreen.iconData),
                onTap: () {
                  NavigationUtils.navigateToRoute(context, navigator, [CarScreen.routeName]);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(HeartScreen.title),
                leading: const Icon(HeartScreen.iconData),
                onTap: () {
                  NavigationUtils.navigateToRoute(context, navigator, [HeartScreen.routeName]);
                },
              ),
              const _GradientDivider(),
              ListTile(
                title: const Text(SettingsScreen.title),
                leading: const Icon(SettingsScreen.iconData),
                onTap: () {
                  NavigationUtils.navigateToRoute(context, navigator, [SettingsScreen.routeName]);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(InfoScreen.title),
                leading: const Icon(InfoScreen.iconData),
                onTap: () {
                  NavigationUtils.navigateToRoute(context, navigator, [InfoScreen.routeName]);
                },
              ),
              const _GradientDivider(),
              ListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  Globals.logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientDivider extends StatelessWidget {
  const _GradientDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.yellow],
          ),
        ),
      ),
    );
  }
}
