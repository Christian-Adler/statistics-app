import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/models/navigation/navigation_item_base.dart';
import 'package:statistics/models/navigation/navigation_item_type.dart';

import '../../providers/main_navigation.dart';
import 'screen_nav_info.dart';

class NavigationItem extends NavigationItemBase {
  ScreenNavInfo screenNavInfo;

  final void Function(BuildContext context)? onNavOverride;

  NavigationItem(this.screenNavInfo, {this.onNavOverride}) : super(NavigationItemType.navigation);

  IconData get iconData => screenNavInfo.iconData;

  String get title => screenNavInfo.title;

  void onNav(BuildContext context) {
    var navOverride = onNavOverride;
    if (navOverride != null) {
      navOverride(context);
      return;
    }
    Provider.of<MainNavigation>(context, listen: false).mainPageRoute = screenNavInfo.routeName;
  }
}
