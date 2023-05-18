import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';

import '../../models/navigation/screen_nav_info.dart';
import '../../utils/global_keys.dart';
import '../../widgets/add_value_floating_button.dart';
import '../../widgets/navigation/app_drawer.dart';
import '../../widgets/responsive/screen_layout_builder.dart';
import '../../widgets/statistics/car/car_add_value.dart';
import '../../widgets/statistics/car/car_view.dart';
import '../../widgets/statistics_app_bar.dart';
import 'car_add_value_screen.dart';

class CarScreen extends StatefulWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    'Tanken',
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
          builder: (context) {
            return AlertDialog(
              title: Text(CarAddValueScreen.screenNavInfo.title),
              content: CarAddValue(key: GlobalKeys.carAddValueState),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
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
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CarAddValueScreen.screenNavInfo.createScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));
    final isLandscapeTablet = mediaQueryInfo.isLandscape && mediaQueryInfo.isTablet;

    return ScreenLayoutBuilder(
      createNestedNavigatorWithKey: CarScreen.screenNavInfo.screensNestedNavigatorKey,
      appBarBuilder: (ctx) => StatisticsAppBar(
        Text(CarScreen.screenNavInfo.title),
        context,
        actions: [
          if (isLandscapeTablet) // als Test zur Veranschaulichung
            IconButton(
              onPressed: () => showAddValue(context),
              // in ScreenLayoutBuilder wird ein neuer Navigator angelegt
              // Der ctx ist unterhalb des nested navigators und findet daher diesen.
              // Wuerde man context verwenden, waere man im Context ueberhalb des nested Navigators
              // - daher wuerde dann der Root-navigator der App gefunden und dessen Stack verwendet.
              tooltip: CarAddValueScreen.screenNavInfo.title,
              icon: const Icon(Icons.add_box_outlined),
            ),
          IconButton(
            onPressed: () => showAddValue(ctx),
            // in ScreenLayoutBuilder wird ein neuer Navigator angelegt
            // Der ctx ist unterhalb des nested navigators und findet daher diesen.
            // Wuerde man context verwenden, waere man im Context ueberhalb des nested Navigators
            // - daher wuerde dann der Root-navigator der App gefunden und dessen Stack verwendet.
            tooltip: CarAddValueScreen.screenNavInfo.title,
            icon: Icon(CarAddValueScreen.screenNavInfo.iconData),
          ),
        ],
      ),
      body: const CarView(),
      drawerBuilder: (ctx) => const AppDrawer(),
      floatingActionButton: const AddValueFloatingButton(),
    );
  }
}
