import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'providers/operating.dart';
import 'screens/auth_screen.dart';
import 'screens/operating/insert_solar_power_value_screen.dart';
import 'screens/operating/operating_chart_screen.dart';
import 'screens/operating/solar_power_chart_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  initializeDateFormatting('de_DE', null).then((_) {
    Intl.defaultLocale = 'de_DE';
    runApp(const MyApp());
  });
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
        ),
        ChangeNotifierProxyProvider<Auth, Operating>(
          create: (ctx) => Operating(null, []),
          update: (ctx, auth, previous) => Operating(auth, previous == null ? [] : previous.solarPowerItems),
        ),
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
            scaffoldBackgroundColor: const Color.fromRGBO(245, 245, 245, 1),
          ),
          home: auth.isAuth
              ? const OperatingChartScreen()
              : FutureBuilder(
                  builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting
                      ? const SplashScreen()
                      : const AuthScreen(),
                  future: auth.tryAutoLogin(),
                ),
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            //
            OperatingChartScreen.routeName: (context) => const OperatingChartScreen(),
            SolarPowerChartScreen.routeName: (context) => const SolarPowerChartScreen(),
            InsertSolarPowerValueScreen.routeName: (context) => const InsertSolarPowerValueScreen(),
            //
            SettingsScreen.routeName: (context) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
