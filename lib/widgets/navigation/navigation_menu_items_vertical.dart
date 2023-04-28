import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../models/navigation/navigation_item.dart';
import '../../models/navigation/navigation_items.dart';

class NavigationMenuItemsVertical extends StatelessWidget {
  const NavigationMenuItemsVertical({Key? key}) : super(key: key);

  List<Widget> buildNavItems(BuildContext context, NavigatorState navigator) {
    List<Widget> result = [];
    for (var navItem in NavigationItems.navigationItems) {
      if (navItem.isNavigation && navItem is NavigationItem) {
        result.add(ListTile(
          title: Text(navItem.title),
          leading: Icon(navItem.iconData),
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
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    return SingleChildScrollView(
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
              ...buildNavItems(context, navigator),
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
