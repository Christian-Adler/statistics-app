import 'package:flutter/material.dart';

import '../screens/operating/operating_screen.dart';
import '../screens/operating/solar_power_screen.dart';
import '../screens/overview_screen.dart';
import '../screens/settings_screen.dart';
import '../utils/globals.dart';
import 'statistics_app_bar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        StatisticsAppBar(
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black26,
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      Globals.assetImgLogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('Statistics'),
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
              SingleChildScrollView(
                child: Column(children: [
                  ListTile(
                    title: const Text('Overview'),
                    leading: const Icon(Icons.home_outlined),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(OverviewScreen.routeName);
                    },
                  ),
                  const Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: const Text('Betriebskosten'),
                    leading: const Icon(Icons.power_input_outlined),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(OperatingScreen.routeName);
                    },
                  ),
                  const Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: const Text('Solar Strom'),
                    leading: const Icon(Icons.solar_power_outlined),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(SolarPowerScreen.routeName);
                    },
                  ),
                  const _GradientDivider(),
                  ListTile(
                    title: const Text('Settings'),
                    leading: const Icon(Icons.settings),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName);
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
                ]),
              ),
            ],
          ),
        ),
      ]),
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
