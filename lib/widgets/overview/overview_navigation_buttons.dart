import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../screens/car/car_screen.dart';
import '../../screens/heart/heart_screen.dart';
import '../../screens/operating/operating_screen.dart';
import '../../screens/operating/solar_power_screen.dart';
import '../layout/single_child_scroll_view_with_scrollbar.dart';
import 'overview_isometric_navigation_button.dart';
import 'overview_large_navigation_button.dart';

class OverviewNavigationButtons extends StatefulWidget {
  const OverviewNavigationButtons({super.key});

  @override
  State<OverviewNavigationButtons> createState() => _OverviewNavigationButtonsState();
}

class _OverviewNavigationButtonsState extends State<OverviewNavigationButtons> {
  List<Widget> _buildNavigationButtons() {
    const separator = SizedBox(height: 30, width: 20);
    bool showIsometric = true;
    if (showIsometric) {
      return [
        separator,
        OverviewIsometricNavigationButton(
          screenNavInfo: OperatingScreen.screenNavInfo,
          edgeColors: const [Color.fromRGBO(4, 118, 229, 1), Color.fromRGBO(0, 198, 238, 1)],
        ),
        separator,
        OverviewIsometricNavigationButton(
          screenNavInfo: SolarPowerScreen.screenNavInfo,
          edgeColors: const [Color.fromRGBO(59, 182, 65, 1), Color.fromRGBO(180, 246, 23, 1)],
        ),
        separator,
        OverviewIsometricNavigationButton(
          screenNavInfo: CarScreen.screenNavInfo,
          edgeColors: const [Color.fromRGBO(250, 161, 26, 1), Color.fromRGBO(251, 220, 33, 1)],
        ),
        separator,
        OverviewIsometricNavigationButton(
          screenNavInfo: HeartScreen.screenNavInfo,
          edgeColors: const [Color.fromRGBO(250, 47, 125, 1), Color.fromRGBO(255, 93, 162, 1)],
        ),
        separator,
      ];
    }

    return [
      separator,
      OverviewLargeNavigationButton(
        screenNavInfo: OperatingScreen.screenNavInfo,
        edgeColors: const [Color.fromRGBO(4, 118, 229, 1), Color.fromRGBO(0, 198, 238, 1)],
      ),
      separator,
      OverviewLargeNavigationButton(
        screenNavInfo: SolarPowerScreen.screenNavInfo,
        edgeColors: const [Color.fromRGBO(59, 182, 65, 1), Color.fromRGBO(180, 246, 23, 1)],
      ),
      separator,
      OverviewLargeNavigationButton(
        screenNavInfo: CarScreen.screenNavInfo,
        edgeColors: const [Color.fromRGBO(250, 161, 26, 1), Color.fromRGBO(251, 220, 33, 1)],
      ),
      separator,
      OverviewLargeNavigationButton(
        screenNavInfo: HeartScreen.screenNavInfo,
        edgeColors: const [Color.fromRGBO(250, 47, 125, 1), Color.fromRGBO(255, 93, 162, 1)],
      ),
      separator,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    var staggeredList = AnimationConfiguration.toStaggeredList(
      duration: const Duration(milliseconds: 375),
      delay: const Duration(milliseconds: 100),
      childAnimationBuilder: (widget) => SlideAnimation(
        horizontalOffset: isLandscape ? 250 : 0,
        verticalOffset: isLandscape ? 0 : 50,
        child: FadeInAnimation(
          child: widget,
        ),
      ),
      children: [..._buildNavigationButtons()],
    );

    if (!isLandscape) {
      return AnimationLimiter(
        child: Column(
          children: staggeredList,
        ),
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 30, width: 20),
          SingleChildScrollViewWithScrollbar(
            scrollDirection: Axis.horizontal,
            child: AnimationLimiter(
              child: Column(
                children: [
                  Row(
                    children: staggeredList,
                  ),
                  const SizedBox(height: 10, width: 20),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
