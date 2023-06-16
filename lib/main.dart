import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'providers/app_layout.dart';
import 'providers/app_locale.dart';
import 'providers/auth.dart';
import 'providers/car.dart';
import 'providers/dynamic_theme_data.dart';
import 'providers/heart.dart';
import 'providers/main_navigation.dart';
import 'providers/operating.dart';
import 'screens/auth_screen.dart';
import 'screens/splash_screen.dart';
import 'utils/date_utils.dart';
import 'utils/global_settings.dart';
import 'utils/logging/daily_files.dart';
import 'utils/logging/log_utils.dart';
import 'utils/theme_utils.dart';
import 'widgets/navigation/app_bottom_navigation_bar.dart';
import 'widgets/navigation/main_navigation_stack.dart';
import 'widgets/responsive/app_layout_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('de_DE', null).then((_) async {
    Intl.defaultLocale = 'de_DE';
    await AppInfo.init();
    await LogUtils.init();
    await DailyFiles.init();
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
          create: (context) => AppLocale(),
        ),
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
        final dynamicThemeData = Provider.of<DynamicThemeData>(context);
        final appLocale = Provider.of<AppLocale>(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppInfo.appName,
          themeMode: dynamicThemeData.themeMode,
          theme: ThemeUtils.buildThemeData(dynamicThemeData, context, false),
          darkTheme: ThemeUtils.buildThemeData(dynamicThemeData, context, true),
          locale: appLocale.locale,
          localizationsDelegates: const [...AppLocalizations.localizationsDelegates, S.delegate],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const _Initializer(),
        );
      },
    );
  }
}

class _Initializer extends StatelessWidget {
  const _Initializer();

  @override
  Widget build(BuildContext context) {
    Provider.of<DynamicThemeData>(context);
    // Nach Sprachwechsel muss DateUtil erneut initialisiert werden.
    Provider.of<AppLocale>(context);
    DateUtil.init();

    // Wenn alle fuer das erste Anzeigen notwendigen Provider geladen sind... dann Home anzeigen.
    // Ansonsten einfach nur einen Container anzeigen um die Zeit auszusitzen in der Sprache
    // und App-Farbe noch nicht klar sind. Ansonsten kann es zum Flackern kommen:
    // Wenn zuerst mit dem Default gezeichnet wird und dann der Provider geladen ist und neu gezeichnet wird.
    if (!GlobalSettings.allFirstDrawRelevantProvidersInitialized()) return Container();

    return const _Home();
  }
}

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return auth.isAuth
        ? AppLayoutBuilder(
            body: const MainNavigationStack(),
            bottomNavigationBarBuilder: () => const AppBottomNavigationBar(),
          )
        : FutureBuilder(
            builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting
                ? const SplashScreen()
                : const AuthScreen(),
            future: auth.tryAutoLogin(),
          );
  }
}
