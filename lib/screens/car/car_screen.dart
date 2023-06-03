import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';

import '../../generated/l10n.dart';
import '../../models/navigation/screen_nav_info.dart';
import '../../utils/global_keys.dart';
import '../../utils/nav/navigation_utils.dart';
import '../../widgets/controls/fab/fab_action_button_data.dart';
import '../../widgets/controls/fab/fab_radial_expandable.dart';
import '../../widgets/controls/fab/fab_vertical_expandable.dart';
import '../../widgets/navigation/app_drawer.dart';
import '../../widgets/responsive/screen_layout_builder.dart';
import '../../widgets/statistics/car/car_add_value.dart';
import '../../widgets/statistics/car/car_view.dart';
import '../../widgets/statistics_app_bar.dart';
import 'car_add_value_screen.dart';

class CarScreen extends StatefulWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleCar,
    Icons.directions_car_outlined,
    '/car',
    () => CarScreen(key: GlobalKeys.carScreenState),
    screensNestedNavigatorKey: GlobalKeys.carScreenNavigatorKey,
  );

  const CarScreen({Key? key}) : super(key: key);

  @override
  State<CarScreen> createState() => CarScreenState();
}

class CarScreenState extends State<CarScreen> {
  void _saveHandler() {
    final currentState = GlobalKeys.carAddValueState.currentState;
    currentState?.saveForm();
  }

  /// Ruft je nach Device addValue in neuem Screen auf im Dialog
  void showAddValue(BuildContext context) {
    final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));

    if (mediaQueryInfo.isTablet && mediaQueryInfo.isPortrait) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(CarAddValueScreen.screenNavInfo.titleBuilder(ctx)),
              content: CarAddValue(key: GlobalKeys.carAddValueState),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Abbrechen')),
                TextButton(
                  onPressed: () {
                    _saveHandler(); // SaveHandler macht bei Erfolg selbst pop
                  },
                  child: const Text('Speichern'),
                )
              ],
            );
          });
    } else {
      NavigationUtils.push(context, CarAddValueScreen.screenNavInfo.createScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));
    final isLandscapeTablet = mediaQueryInfo.isLandscape && mediaQueryInfo.isTablet;

    return ScreenLayoutBuilder(
      createNestedNavigatorWithKey: CarScreen.screenNavInfo.screensNestedNavigatorKey,
      appBarBuilder: (ctx) => StatisticsAppBar(
        Text(CarScreen.screenNavInfo.titleBuilder(ctx)),
        ctx,
        actions: [
          if (isLandscapeTablet) // als Test zur Veranschaulichung
            IconButton(
              onPressed: () => showAddValue(context),
              // in ScreenLayoutBuilder wird ein neuer Navigator angelegt
              // Der ctx ist unterhalb des nested navigators und findet daher diesen.
              // Wuerde man context verwenden, waere man im Context ueberhalb des nested Navigators
              // - daher wuerde dann der Root-navigator der App gefunden und dessen Stack verwendet.
              tooltip: CarAddValueScreen.screenNavInfo.titleBuilder(ctx),
              icon: const Icon(Icons.add_box_outlined),
            ),
          IconButton(
            onPressed: () => showAddValue(ctx),
            // in ScreenLayoutBuilder wird ein neuer Navigator angelegt
            // Der ctx ist unterhalb des nested navigators und findet daher diesen.
            // Wuerde man context verwenden, waere man im Context ueberhalb des nested Navigators
            // - daher wuerde dann der Root-navigator der App gefunden und dessen Stack verwendet.
            tooltip: CarAddValueScreen.screenNavInfo.titleBuilder(ctx),
            icon: Icon(CarAddValueScreen.screenNavInfo.iconData),
          ),
        ],
      ),
      bodyBuilder: (ctx) => const CarView(),
      drawerBuilder: (ctx) => const AppDrawer(),
      floatingActionButtonBuilder: (ctx) {
        final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));
        final isLandscapePhone = mediaQueryInfo.isLandscape && !mediaQueryInfo.isTablet;

        var fabActions = [
          FabActionButtonData(
            Icons.add_box,
            () => showAddValue(context),
          ),
          FabActionButtonData(
            CarAddValueScreen.screenNavInfo.iconData,
            () => showAddValue(ctx),
          ),
        ];

        if (isLandscapePhone) {
          return FabRadialExpandable(
            distance: 100.0,
            maxAngle: 70,
            startAngle: 10,
            actions: fabActions,
          );
        }
        return FabVerticalExpandable(
          distance: 70.0,
          actions: fabActions,
        );
      },
    );
  }
}
