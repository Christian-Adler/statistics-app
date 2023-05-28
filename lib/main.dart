import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/safe_area_info.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'models/app_info.dart';
import 'providers/app_layout.dart';
import 'providers/auth.dart';
import 'providers/car.dart';
import 'providers/dynamic_theme_data.dart';
import 'providers/heart.dart';
import 'providers/main_navigation.dart';
import 'providers/operating.dart';
import 'screens/auth_screen.dart';
import 'screens/splash_screen.dart';
import 'widgets/navigation/app_bottom_navigation_bar.dart';
import 'widgets/navigation/main_navigation_stack.dart';
import 'widgets/responsive/app_layout_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppInfo.init();
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
          create: (context) => DynamicThemeData(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainNavigation(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppLayout(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Operating>(
          create: (ctx) => Operating(null, [], []),
          update: (ctx, auth, previous) => Operating(auth, [], []),
          // Wenn auth sich aendert, dann Operating zurueck setzen
          // Operating(auth, previous == null ? [] : previous.operatingItems,
          // previous == null ? [] : previous.operatingItemsYearly),
        ),
        ChangeNotifierProxyProvider<Auth, Car>(
          create: (ctx) => Car(null, []),
          update: (ctx, auth, previous) => Car(auth, []),
        ),
        ChangeNotifierProxyProvider<Auth, Heart>(
          create: (ctx) => Heart(null, []),
          update: (ctx, auth, previous) => Heart(auth, []),
        ),
      ],
      builder: (context, _) {
        final auth = Provider.of<Auth>(context);
        final dynamicThemeData = Provider.of<DynamicThemeData>(context);

        SafeAreaInfo.determineSafeAreaHeight(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppInfo.appName,
          theme: ThemeData(
            primaryColor: dynamicThemeData.primaryColor,
            // Colors.purple,
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: dynamicThemeData.primaryColor /* Colors.purple */).copyWith(
              secondary: Colors.amber,
              //   onPrimary: Colors.white, Farbe die auf primary verwendet wird.
            ),
            textTheme: Theme.of(context).textTheme.copyWith(
                  titleLarge: TextStyle(color: Colors.purple.shade900),
                  titleSmall: TextStyle(color: Colors.purple.shade900),
                ),
            drawerTheme: Theme.of(context).drawerTheme.copyWith(backgroundColor: Colors.white),
            scaffoldBackgroundColor: const Color.fromRGBO(245, 245, 245, 1),
            scrollbarTheme: Theme.of(context).scrollbarTheme.copyWith(
                  thumbColor: MaterialStatePropertyAll(dynamicThemeData.primaryColor /* Colors.purple */),
                  radius: Radius.zero,
                  interactive: true,
                  // thickness: const MaterialStatePropertyAll(10),
                  // thumbVisibility: const MaterialStatePropertyAll(true),
                  // trackVisibility: const MaterialStatePropertyAll(true),
                  // trackColor: const MaterialStatePropertyAll(Colors.blueAccent),
                  // trackBorderColor: const MaterialStatePropertyAll(Colors.purpleAccent),
                ),
          ),
          home: auth.isAuth
              ? AppLayoutBuilder(
                  body: const MainNavigationStack(),
                  bottomNavigationBarBuilder: () => const AppBottomNavigationBar(),
                )
              : FutureBuilder(
                  builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting
                      ? const SplashScreen()
                      : const AuthScreen(),
                  future: auth.tryAutoLogin(),
                ),
        );
      },
    );
  }
}
