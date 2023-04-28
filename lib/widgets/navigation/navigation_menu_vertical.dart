import 'package:flutter/material.dart';

import '../../utils/globals.dart';
import 'navigation_menu_items_vertical.dart';

class NavigationMenuVertical extends StatelessWidget {
  const NavigationMenuVertical({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(
                  Globals.assetImgBackground,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        const NavigationMenuItemsVertical(),
      ],
    );
  }
}
