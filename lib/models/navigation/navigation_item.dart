import 'package:flutter/material.dart';
import 'package:statistics/models/navigation/navigation_item_base.dart';
import 'package:statistics/models/navigation/navigation_item_type.dart';

import 'screen_nav_info.dart';

class NavigationItem extends NavigationItemBase {
  ScreenNavInfo screenNavInfo;
  final void Function(BuildContext context, NavigatorState navigator) onNav;

  NavigationItem(this.screenNavInfo, this.onNav) : super(NavigationItemType.navigation);

  IconData get iconData => screenNavInfo.iconData;

  String get title => screenNavInfo.title;
}
