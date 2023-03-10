import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:statistics/screens/operating/operating_add_value_screen.dart';

import 'providers/auth.dart';
import 'providers/operating.dart';
import 'screens/auth_screen.dart';
import 'screens/operating/operating_screen.dart';
import 'screens/operating/solar_power_add_value_screen.dart';
import 'screens/operating/solar_power_screen.dart';
import 'screens/overview_screen.dart';
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
          create: (ctx) => Operating(null, [], []),
          update: (ctx, auth, previous) =>
              Operating(auth, [], []), // Wenn auth sich aendert, dann Operating zurueck setzen
          // Operating(auth, previous == null ? [] : previous.operatingItems,
          // previous == null ? [] : previous.operatingItemsYearly),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
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
              ? const OverviewScreen()
              : FutureBuilder(
                  builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting
                      ? const SplashScreen()
                      : const AuthScreen(),
                  future: auth.tryAutoLogin(),
                ),
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            //
            OverviewScreen.routeName: (context) => const OverviewScreen(),
            //
            OperatingScreen.routeName: (context) => const OperatingScreen(),
            OperatingAddValueScreen.routeName: (context) => const OperatingAddValueScreen(),
            SolarPowerScreen.routeName: (context) => const SolarPowerScreen(),
            SolarPowerAddValueScreen.routeName: (context) => const SolarPowerAddValueScreen(),
            //
            SettingsScreen.routeName: (context) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
