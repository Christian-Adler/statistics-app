import 'package:flutter/material.dart';

import '../../utils/globals.dart';
import '../layout/single_child_scroll_view_with_scrollbar.dart';
import 'overview_footer.dart';
import 'overview_navigation_buttons.dart';

class Overview extends StatelessWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Stack(
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
          ),
        ),
        const OverviewFooter(),
      ],
    );
  }
}
