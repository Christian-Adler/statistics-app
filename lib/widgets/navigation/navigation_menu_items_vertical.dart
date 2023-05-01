import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../models/navigation/navigation_item.dart';
import '../../models/navigation/navigation_items.dart';
import '../../screens/overview_screen.dart';
import '../../utils/nav/navigation_utils.dart';
import '../layout/single_child_scroll_view_with_scrollbar.dart';

class NavigationMenuItemsVertical extends StatelessWidget {
  final bool showNavigationTitle;

  const NavigationMenuItemsVertical(this.showNavigationTitle, {Key? key}) : super(key: key);

  List<Widget> _buildNavItems(BuildContext context, NavigatorState navigator) {
    var actRouteName = NavigationUtils.getActRouteSettings(context)?.name ?? '/';
    List<Widget> result = [];
    for (var navItem in NavigationItems.navigationMenuItems) {
      if (navItem.isNavigation && navItem is NavigationItem) {
        bool isActNavItem = false;
        if (actRouteName == '/') {
          if (navItem.screenNavInfo.routeName == OverviewScreen.screenNavInfo.routeName) isActNavItem = true;
        } else if (navItem.screenNavInfo.routeName.contains(actRouteName)) {
          isActNavItem = true;
        }
        result.add(ListTile(
          iconColor: isActNavItem ? Colors.purple : null,
          title: showNavigationTitle ? Text(navItem.title) : Icon(navItem.iconData),
          leading: showNavigationTitle ? Icon(navItem.iconData) : null,
          onTap: () {
            navItem.onNav(context, navigator);
          },
        ));
      } else if (navItem.isDividerSmall) {
        result.add(const Divider(height: 1));
      } else if (navItem.isDividerLarge) {
        result.add(const _GradientDivider());
      }
    }

    // Wenn nur Icons, dann unten nochmal Platz wg. Hintergrundbild
    if (!showNavigationTitle) {
      result.add(const SizedBox(
        height: 50,
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    return SingleChildScrollViewWithScrollbar(
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            // delay: const Duration(milliseconds: 10),
            duration: const Duration(milliseconds: 175),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              ..._buildNavItems(context, navigator),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientDivider extends StatelessWidget {
  const _GradientDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.yellow],
          ),
        ),
      ),
    );
  }
}
