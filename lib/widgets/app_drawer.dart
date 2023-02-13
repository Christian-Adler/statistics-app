import 'package:flutter/material.dart';

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
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app))],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              const Divider(),
              ListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.of(context).pop(); // close drawer
                  Navigator.of(context).pushReplacementNamed('/'); // goto home (after Logout is home LoginScreen)
                  // TODO Auth logout
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.yellow],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
