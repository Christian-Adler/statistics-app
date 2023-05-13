import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/models/navigation/navigation_items.dart';
import 'package:statistics/widgets/responsive/app_layout_builder.dart';

import '../../providers/main_navigation.dart';
import 'app_bottom_navigation_bar.dart';

class MainNavigationStack extends StatelessWidget {
  const MainNavigationStack({Key? key}) : super(key: key);

  List<Widget> _buildLazyMainNavigationChildren(BuildContext context, int mainPageIndex) {
    final visited = Provider.of<MainNavigation>(context, listen: false).visitedIndexes;

    List<Widget> widgets = [];

    for (var i = 0; i < NavigationItems.mainNavigationItems.length; ++i) {
      var navigationItem = NavigationItems.mainNavigationItems[i];
      if (visited.contains(i)) {
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

    return AppLayoutBuilder(
      body: IndexedStack(
        index: mainPageIndex,
        children: _buildLazyMainNavigationChildren(context, mainPageIndex),
      ),
      bottomNavigationBarBuilder: () => const AppBottomNavigationBar(),
    );
  }
}
