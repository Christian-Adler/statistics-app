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
      Navigator.of(context).pushNamed(CarAddValueScreen.screenNavInfo.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      appBar: StatisticsAppBar(
        Text(CarScreen.screenNavInfo.title),
        context,
        actions: [
          IconButton(
            onPressed: () => showAddValue(context),
            tooltip: CarAddValueScreen.screenNavInfo.title,
            icon: Icon(CarAddValueScreen.screenNavInfo.iconData),
          ),
        ],
      ),
      body: const CarView(),
      drawerBuilder: () => const AppDrawer(),
      floatingActionButton: const AddValueFloatingButton(),
    );
  }
}
