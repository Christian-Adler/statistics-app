import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/hide_bottom_navigation_bar.dart';
import 'package:flutter_commons/widgets/layout/single_child_scroll_view_with_scrollbar.dart';
import 'package:provider/provider.dart';

import '../../providers/app_layout.dart';
import '../../utils/global_keys.dart';
import '../../utils/globals.dart';
import '../../utils/theme_utils.dart';
import 'overview_footer.dart';
import 'overview_navigation_buttons.dart';
import 'parallax/overview_parallax.dart';

class Overview extends StatelessWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: OverviewBody(),
        ),
        OverviewFooter(),
      ],
    );
  }
}

class OverviewBody extends StatelessWidget {
  const OverviewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLayout = Provider.of<AppLayout>(context);
    if (appLayout.enableOverviewParallax) {
      return OverviewParallax(
        key: GlobalKeys.overviewParallaxKey,
        darkMode: ThemeUtils.isDarkMode(context),
      );
    }

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Globals.assetImgBackground,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        const SingleChildScrollViewWithScrollbar(
          scrollPositionHandler: HideBottomNavigationBar.setScrollPosition,
          child: Center(child: OverviewNavigationButtons()),
        ),
      ],
    );
  }
}
