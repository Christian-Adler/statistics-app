import 'package:flutter/material.dart';
import 'package:statistics/models/navigation/navigation_item_base.dart';
import 'package:statistics/models/navigation/navigation_item_type.dart';

import 'screen_nav_info.dart';

class NavigationItem extends NavigationItemBase {
  final IconData iconData;
  final String title;
  final void Function(BuildContext context, NavigatorState navigator) onNav;

  NavigationItem(ScreenNavInfo screenNavInfo, this.onNav)
      : iconData = screenNavInfo.iconData,
        title = screenNavInfo.title,
        super(NavigationItemType.navigation);
}
