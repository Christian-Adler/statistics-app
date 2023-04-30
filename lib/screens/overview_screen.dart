import 'package:flutter/material.dart';
import 'package:flutter_commons/widgets/double_back_to_close.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../models/navigation/screen_nav_info.dart';
import '../providers/auth.dart';
import '../utils/globals.dart';
import '../utils/nav/navigation_utils.dart';
import '../widgets/add_value_floating_button.dart';
import '../widgets/layout/single_child_scroll_view_with_scrollbar.dart';
import '../widgets/logo/eagle_logo.dart';
import '../widgets/navigation/app_bottom_navigation_bar.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/responsive/screen_layout_builder.dart';
import '../widgets/statistics_app_bar.dart';
import 'car/car_screen.dart';
import 'heart/heart_screen.dart';
import 'operating/operating_screen.dart';
import 'operating/solar_power_screen.dart';

class OverviewScreen extends StatelessWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Übersicht', Icons.home_outlined, '/overview');

  const OverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      appBar: StatisticsAppBar(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(OverviewScreen.screenNavInfo.title),
            const EagleLogo(),
          ],
        ),
        context,
      ),
      body: const _OverviewScreenBody(),
      drawerBuilder: () => const AppDrawer(),
      bottomNavigationBarBuilder: () => const AppBottomNavigationBar(),
      floatingActionButton: const AddValueFloatingButton(),
    );
  }
}

class _OverviewScreenBody extends StatelessWidget {
  const _OverviewScreenBody();

  @override
  Widget build(BuildContext context) {
    return DoubleBackToClose(
      child: Column(
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
                SingleChildScrollViewWithScrollbar(
                  child: Center(child: _NavigationButtons()),
                ),
              ],
            ),
          ),
          const _Footer(),
        ],
      ),
    );
  }
}

class _NavigationButtons extends StatefulWidget {
  @override
  State<_NavigationButtons> createState() => _NavigationButtonsState();
}

class _NavigationButtonsState extends State<_NavigationButtons> {
  List<Widget> _buildNavigationButtons() {
    return [
      const SizedBox(height: 30, width: 20),
      const _RoundedBtn(
        screenNavInfo: OperatingScreen.screenNavInfo,
        edgeColors: [Color.fromRGBO(4, 118, 229, 1), Color.fromRGBO(0, 198, 238, 1)],
      ),
      const SizedBox(height: 30, width: 20),
      const _RoundedBtn(
        screenNavInfo: SolarPowerScreen.screenNavInfo,
        edgeColors: [Color.fromRGBO(59, 182, 65, 1), Color.fromRGBO(180, 246, 23, 1)],
      ),
      const SizedBox(height: 30, width: 20),
      const _RoundedBtn(
        screenNavInfo: CarScreen.screenNavInfo,
        edgeColors: [Color.fromRGBO(250, 161, 26, 1), Color.fromRGBO(251, 220, 33, 1)],
      ),
      const SizedBox(height: 30, width: 20),
      const _RoundedBtn(
        screenNavInfo: HeartScreen.screenNavInfo,
        edgeColors: [Color.fromRGBO(250, 47, 125, 1), Color.fromRGBO(255, 93, 162, 1)],
      ),
      const SizedBox(height: 30, width: 20),
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

class _RoundedBtn extends StatelessWidget {
  final ScreenNavInfo screenNavInfo;
  final List<Color> edgeColors;

  const _RoundedBtn({required this.edgeColors, required this.screenNavInfo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            width: 200,
            height: 15,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: edgeColors, begin: AlignmentDirectional.topStart, end: AlignmentDirectional.bottomEnd),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(2)),
                // border: Border.all(width: 1, color: Colors.grey.shade300),
                // boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
              ),
            ),
          ),
          Positioned(
            top: 2,
            right: 2,
            width: 218,
            height: 98,
            child: _LargeNavigationButton(
                screenNavInfo.routeName, screenNavInfo.title, screenNavInfo.iconData, edgeColors[0], edgeColors[1]),
          ),
        ],
      ),
    );
  }
}

class _LargeNavigationButton extends StatelessWidget {
  final String text;
  final String routeName;
  final IconData iconData;
  final Color color;
  final Color color2;

  const _LargeNavigationButton(
    this.routeName,
    this.text,
    this.iconData,
    this.color,
    this.color2,
  );

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: const ButtonStyle(
        // minimumSize: MaterialStatePropertyAll(Size(200, 100)),
        // elevation: MaterialStatePropertyAll(5),
        backgroundColor: MaterialStatePropertyAll(Colors.white70),
      ),
      // onPressed: () => Navigator.of(context).pushNamed(routeName),
      onPressed: () {
        NavigationUtils.navigateToRoute(context, Navigator.of(context), [routeName]);
      },
      icon: Icon(
        iconData,
        size: 44,
        color: color2,
      ),
      label: Text(text, style: TextStyle(color: color)),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary])),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Icon(
            Icons.alternate_email,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(width: 10),
          Text(
            Provider.of<Auth>(context, listen: false).serverUrl,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
