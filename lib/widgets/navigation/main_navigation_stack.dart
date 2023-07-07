import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/navigation/navigation_items.dart';
import '../../providers/main_navigation.dart';

class MainNavigationStack extends StatelessWidget {
  const MainNavigationStack({Key? key}) : super(key: key);

  List<Widget> _buildLazyMainNavigationChildren(BuildContext context, int mainPageIndex) {
    final visited = Provider.of<MainNavigation>(context, listen: false).visitedIndexes;

    List<Widget> widgets = [];

    for (var i = 0; i < NavigationItems.mainNavigationItems.length; ++i) {
      var navigationItem = NavigationItems.mainNavigationItems[i];

      // Schon besucht? && (aktuelle Seite || State soll erhalten bleiben)
      if (visited.contains(i) && (i == mainPageIndex || !navigationItem.disposeIfNotVisible)) {
        // Hier bleibt der State erhalten. Wenn der State nicht erhalten bleiben soll
        // (z.B. nested Navigator soll zurueck gesetzt werden usw.) dann nur createScreen, wenn aktiver Tab.
        widgets.add(navigationItem.screenNavInfo.createScreen());
      } else {
        widgets.add(Container());
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    int mainPageIndex = Provider.of<MainNavigation>(context).mainPageIndex;

    return IndexedStack(
      index: mainPageIndex,
      children: _buildLazyMainNavigationChildren(context, mainPageIndex),
    );
  }
}
