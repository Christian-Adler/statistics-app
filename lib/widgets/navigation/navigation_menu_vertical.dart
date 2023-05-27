import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/safe_area_info.dart';

import '../../utils/global_settings.dart';
import '../../utils/globals.dart';
import 'navigation_menu_items_vertical.dart';

class NavigationMenuVertical extends StatelessWidget {
  final bool showNavigationTitle;

  const NavigationMenuVertical(this.showNavigationTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    // Size veraendert sicht nicht, wenn onScreenKeyboard angezeigt wird.
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SingleChildScrollView(
          child: SizedBox(
            height: screenHeight - GlobalSettings.appBarHeight - SafeAreaInfo.safeAreaHeight, // - AppBar - SafeArea
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: showNavigationTitle ? 100 : 50,
                  child: Image.asset(
                    Globals.assetImgBackground,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
        NavigationMenuItemsVertical(showNavigationTitle),
      ],
    );
  }
}
