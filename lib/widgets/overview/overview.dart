import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:provider/provider.dart';

import '../../providers/app_layout.dart';
import '../../utils/global_keys.dart';
import '../../utils/globals.dart';
import '../layout/single_child_scroll_view_with_scrollbar.dart';
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
    final mediaQueryInfo = MediaQueryUtils.of(context);
    final appLayout = Provider.of<AppLayout>(context);
    if (appLayout.enableOverviewParallax && mediaQueryInfo.isTablet && mediaQueryInfo.isLandscape) {
      return OverviewParallax(
        key: GlobalKeys.overviewParallaxKey,
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
          // No BottomNavBar hide on Overview Screen // scrollDirectionCallback: HideBottomNavigationBar.setScrollDirection,
          child: Center(child: OverviewNavigationButtons()),
        ),
      ],
    );
  }
}
