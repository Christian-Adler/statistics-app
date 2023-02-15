import 'package:flutter/material.dart';
import 'package:statistics/screens/chart_screen.dart';
import 'package:statistics/screens/settings_screen.dart';

import '../models/globals.dart';
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
          child: SingleChildScrollView(
            child: Column(children: [
              ListTile(
                title: const Text('Charts'),
                leading: const Icon(Icons.multiline_chart),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(ChartScreen.routeName);
                },
              ),
              const Divider(
                height: 1,
              ),
              ListTile(
                title: const Text('Settings'),
                leading: const Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.yellow],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  Globals.logout(context);
                },
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
