import 'package:flutter/material.dart';
import 'package:statistics/screens/chart_screen.dart';
import 'package:statistics/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Statistics',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
          secondary: Colors.amber,
          //   onPrimary: Colors.white, Farbe die auf primary verwendet wird.
        ),
        textTheme: Theme.of(context).textTheme,
      ),
      home: const ChartScreen(),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        ChartScreen.routeName: (context) => const ChartScreen(),
      },
    );
  }
}
