import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/providers/auth.dart';
import 'package:statistics/screens/power_chart_screen.dart';
import 'package:statistics/screens/settings_screen.dart';
import 'package:statistics/screens/solar_power_chart_screen.dart';
import 'package:statistics/screens/splash_screen.dart';

import 'screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Statistics',
          theme: ThemeData(
            primaryColor: Colors.purple,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
              secondary: Colors.amber,
              //   onPrimary: Colors.white, Farbe die auf primary verwendet wird.
            ),
            textTheme: Theme.of(context).textTheme.copyWith(
                  titleLarge: TextStyle(color: Colors.purple.shade900),
                ),
          ),
          home: auth.isAuth
              ? const PowerChartScreen()
              : FutureBuilder(
                  builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting
                      ? const SplashScreen()
                      : const AuthScreen(),
                  future: auth.tryAutoLogin(),
                ),
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            PowerChartScreen.routeName: (context) => const PowerChartScreen(),
            SolarPowerChartScreen.routeName: (context) => const SolarPowerChartScreen(),
            SettingsScreen.routeName: (context) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
