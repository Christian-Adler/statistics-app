import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';

import '../../models/navigation/screen_nav_info.dart';
import '../../utils/global_keys.dart';
import '../../widgets/add_value_floating_button.dart';
import '../../widgets/navigation/app_bottom_navigation_bar.dart';
import '../../widgets/navigation/app_drawer.dart';
import '../../widgets/responsive/screen_layout_builder.dart';
import '../../widgets/statistics/operating/operating_add_value.dart';
import '../../widgets/statistics/operating/operating_view.dart';
import '../../widgets/statistics_app_bar.dart';
import 'operating_add_value_screen.dart';

class OperatingScreen extends StatefulWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    'Nebenkosten',
    Icons.power_input_outlined,
    '/operating',
    () => OperatingScreen(key: GlobalKeys.operatingScreenState),
  );

  const OperatingScreen({Key? key}) : super(key: key);

  @override
  State<OperatingScreen> createState() => OperatingScreenState();
}

class OperatingScreenState extends State<OperatingScreen> {
  bool _showYearly = false;

  void _toggleYearly() {
    setState(() {
      _showYearly = !_showYearly;
    });
  }

  void _saveHandler() {
    final currentState = GlobalKeys.operatingAddValueState.currentState;
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
              title: Text(OperatingAddValueScreen.screenNavInfo.title),
              content: OperatingAddValue(key: GlobalKeys.operatingAddValueState),
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
      Navigator.of(context).pushNamed(OperatingAddValueScreen.screenNavInfo.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      appBar: StatisticsAppBar(
        Text(OperatingScreen.screenNavInfo.title),
        context,
        actions: [
          IconButton(
            onPressed: () => _toggleYearly(),
            tooltip: 'Zeige ${_showYearly ? 'Monatsansicht' : 'Jahresansicht'}',
            icon: Icon(_showYearly ? Icons.calendar_month_outlined : Icons.calendar_today_outlined),
          ),
          IconButton(
            onPressed: () => showAddValue(context),
            tooltip: OperatingAddValueScreen.screenNavInfo.title,
            icon: Icon(OperatingAddValueScreen.screenNavInfo.iconData),
          ),
        ],
      ),
      body: OperatingView(showYearly: _showYearly),
      drawerBuilder: () => const AppDrawer(),
      bottomNavigationBarBuilder: () => const AppBottomNavigationBar(),
      floatingActionButton: const AddValueFloatingButton(),
    );
  }
}
