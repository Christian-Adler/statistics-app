import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../models/navigation/navigation_item.dart';
import '../../models/navigation/navigation_items.dart';
import '../../screens/overview_screen.dart';
import '../../utils/global_settings.dart';
import '../../utils/nav/navigation_utils.dart';
import '../layout/single_child_scroll_view_with_scrollbar.dart';

class NavigationMenuItemsVertical extends StatelessWidget {
  final bool showNavigationTitle;

  const NavigationMenuItemsVertical(this.showNavigationTitle, {Key? key}) : super(key: key);

  List<Widget> _buildNavItems(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onPrimaryColor = colorScheme.onPrimary;
    final actRouteName = NavigationUtils.getActRouteSettings(context)?.name ?? '/';

    List<Widget> result = [];
    for (var navItem in NavigationItems.navigationMenuItems) {
      if (navItem.isNavigation && navItem is NavigationItem) {
        bool isActNavItem = false;
        if (actRouteName == '/') {
          if (navItem.screenNavInfo.routeName == OverviewScreen.screenNavInfo.routeName) isActNavItem = true;
        } else if (navItem.screenNavInfo.routeName.contains(actRouteName)) {
          isActNavItem = true;
        }

        var navIcon = Icon(navItem.iconData, color: isActNavItem ? onPrimaryColor : null);
        final widget = Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
          child: Container(
            decoration: BoxDecoration(
              gradient: isActNavItem
                  ? LinearGradient(
                      colors: [
                        colorScheme.primary,
                        colorScheme.secondary,
                      ],
                    )
                  : null,
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            child: ListTile(
              selected: isActNavItem,
              title: showNavigationTitle
                  ? Text(
                      navItem.title,
                      style: TextStyle(
                          color: isActNavItem ? onPrimaryColor : null,
                          fontWeight: isActNavItem ? FontWeight.bold : null),
                    )
                  : navIcon,
              leading: showNavigationTitle ? navIcon : null,
              onTap: () {
                navItem.onNav(context);
              },
            ),
          ),
        );

        result.add(widget);
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
    // Keine Animation, wenn Drawer die ganze Zeit sichtbar ist.
    if (MediaQueryUtils.mediaIsTablet(MediaQuery.of(context))) {
      return SingleChildScrollViewWithScrollbar(
        getScrollPos: () => GlobalSettings.menuScrollPos,
        setScrollPos: (value) => GlobalSettings.menuScrollPos = value,
        child: Column(
          children: [
            ..._buildNavItems(context),
          ],
        ),
      );
    }

    return SingleChildScrollViewWithScrollbar(
      getScrollPos: () => GlobalSettings.menuScrollPos,
      setScrollPos: (value) => GlobalSettings.menuScrollPos = value,
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
              ..._buildNavItems(context),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
      ),
    );
  }
}
