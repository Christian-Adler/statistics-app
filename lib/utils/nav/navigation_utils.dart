import 'package:flutter/material.dart';

class NavigationUtils {
  /// Bis hoch zu root navigieren (falls notwendig)
  /// und dann die (notwendigen) Routen pushen
  static void navigateToRoute(BuildContext ctx, NavigatorState navigator, List<String> routeNames) {
    var routeIdx = -1;
    // print('act route:');
    // print(ModalRoute.of(ctx)?.settings.name);

    closeDrawerIfOpen(ctx);

    // Go back in navigation until match or root
    navigator.popUntil((route) {
      var actRouteName = route.settings.name ?? '/';
      // print('actRouteName: ${actRouteName!}');
      // root/Home erreicht?
      if (actRouteName == '/') {
        routeIdx = 0;
        return true;
      }
      routeIdx = routeNames.indexOf(actRouteName) + 1; // +1 : wenn nicht gefunden bei index 0 anfangen
      return routeIdx > 0;
      // return routeNames.contains(actRouteName);
    });

    // print('route idx: ${routeIdx}');

    for (var i = routeIdx; i < routeNames.length; ++i) {
      var routeName = routeNames[i];
      // print('push RouteName: $routeName');
      navigator.pushNamed(routeName);
    }
  }

  static RouteSettings? getActRouteSettings(BuildContext ctx) {
    return ModalRoute.of(ctx)?.settings;
  }

  static bool closeDrawerIfOpen(BuildContext context) {
    // print('Close drawer if open...');
    // Drawer offen? Dann zuerst schliessen
    // var scaffoldState = Scaffold.of(context);
    var scaffoldState = Scaffold.maybeOf(context);
    // print('scaffold state ');
    // print(scaffoldState);
    if (scaffoldState != null && scaffoldState.isDrawerOpen) {
      // print('Close drawer');
      scaffoldState.closeDrawer();
      return true;
    }
    return false;
  }
}
