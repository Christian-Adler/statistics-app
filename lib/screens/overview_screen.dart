import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:statistics/screens/car/car_screen.dart';
import 'package:statistics/screens/heart/heart_screen.dart';
import 'package:statistics/utils/style_utils.dart';
import 'package:statistics/widgets/app_bar_logo.dart';

import '../providers/auth.dart';
import '../utils/globals.dart';
import '../widgets/add_value_floating_button.dart';
import '../widgets/app_drawer.dart';
import '../widgets/statistics_app_bar.dart';
import 'operating/operating_screen.dart';
import 'operating/solar_power_screen.dart';

class OverviewScreen extends StatelessWidget {
  static const String routeName = '/overview';

  const OverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Statistics'),
            AppBarLogo(),
          ],
        ),
        context,
      ),
      drawer: const AppDrawer(),
      body: Column(
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
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _RoundedBtn(
                            title: 'Nebenk.',
                            iconData: Icons.power_input_outlined,
                            edgeColors: const LinearGradient(
                                colors: [Color.fromRGBO(4, 159, 231, 1), Color.fromRGBO(0, 112, 183, 1)],
                                begin: AlignmentDirectional.topStart,
                                end: AlignmentDirectional.bottomEnd),
                            borderRadius: StyleUtils.buildBorderRadius(70, 20, 20, 70),
                            onTab: () {
                              Navigator.of(context).pushReplacementNamed(OperatingScreen.routeName);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                            width: 20,
                          ),
                          _RoundedBtn(
                            title: 'Solar',
                            iconData: Icons.solar_power_outlined,
                            edgeColors: const LinearGradient(
                                colors: [Color.fromRGBO(4, 159, 75, 1), Color.fromRGBO(195, 225, 36, 1)],
                                begin: AlignmentDirectional.bottomStart,
                                end: AlignmentDirectional.topEnd),
                            borderRadius: StyleUtils.buildBorderRadius(20, 70, 70, 20),
                            onTab: () {
                              Navigator.of(context).pushReplacementNamed(SolarPowerScreen.routeName);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _RoundedBtn(
                            title: 'Tanken',
                            iconData: Icons.directions_car_outlined,
                            edgeColors: const LinearGradient(
                                colors: [Color.fromRGBO(255, 207, 33, 1), Color.fromRGBO(250, 67, 60, 1)],
                                begin: AlignmentDirectional.bottomStart,
                                end: AlignmentDirectional.topEnd),
                            borderRadius: StyleUtils.buildBorderRadius(20, 70, 70, 20),
                            onTab: () {
                              Navigator.of(context).pushReplacementNamed(CarScreen.routeName);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                            width: 20,
                          ),
                          _RoundedBtn(
                            title: 'Blutdruck',
                            iconData: Icons.monitor_heart_outlined,
                            edgeColors: const LinearGradient(
                                colors: [Color.fromRGBO(181, 35, 150, 1), Color.fromRGBO(239, 88, 121, 1)],
                                begin: AlignmentDirectional.topStart,
                                end: AlignmentDirectional.bottomEnd),
                            borderRadius: StyleUtils.buildBorderRadius(70, 20, 20, 70),
                            onTab: () {
                              Navigator.of(context).pushReplacementNamed(HeartScreen.routeName);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                        height: 1,
                      ),
                      const SizedBox(height: 20),
                      _NavigationButtons(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const _Footer(),
        ],
      ),
      floatingActionButton: const AddValueFloatingButton(),
    );
  }
}

class _RoundedBtn extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Gradient edgeColors;
  final BorderRadius borderRadius;
  final VoidCallback onTab;

  const _RoundedBtn({
    required this.edgeColors,
    required this.borderRadius,
    required this.onTab,
    required this.title,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 5,
            width: 110,
            height: 110,
            child: Container(
              decoration: BoxDecoration(
                gradient: edgeColors,
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                // border: Border.all(width: 1, color: Colors.grey.shade300),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
              ),
            ),
          ),
          Positioned(
            left: 0,
            width: 120,
            height: 120,
            child: Material(
              borderRadius: borderRadius,
              elevation: 4,
              color: Colors.white,
              child: InkWell(
                splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                highlightColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: borderRadius,
                onTap: onTab,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconData,
                      color: Theme.of(context).colorScheme.primary,
                      size: 60,
                      shadows: const [Shadow(color: Colors.black26, blurRadius: 10)],
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
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
      const _LargeNavigationButton(OperatingScreen.routeName, 'Nebenkosten', Icons.power_input_outlined),
      const SizedBox(height: 20, width: 20),
      const _LargeNavigationButton(SolarPowerScreen.routeName, 'Solar Strom', Icons.solar_power_outlined),
      const SizedBox(height: 20, width: 20),
      const _LargeNavigationButton(CarScreen.routeName, 'Tanken', Icons.directions_car_outlined),
      const SizedBox(height: 20, width: 20),
      const _LargeNavigationButton(HeartScreen.routeName, 'Blutdruck', Icons.monitor_heart_outlined),
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
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: staggeredList,
        ),
      );
    }
  }
}

class _LargeNavigationButton extends StatelessWidget {
  final String text;
  final String routeName;
  final IconData iconData;

  const _LargeNavigationButton(
    this.routeName,
    this.text,
    this.iconData,
  );

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: const ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size(200, 100)),
        // elevation: MaterialStatePropertyAll(5),
        backgroundColor: MaterialStatePropertyAll(Colors.white70),
      ),
      onPressed: () => Navigator.of(context).pushReplacementNamed(routeName),
      icon: Icon(
        iconData,
        size: 44,
      ),
      label: Text(text),
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
