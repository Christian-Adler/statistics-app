import 'package:flutter/material.dart';
import 'package:flutter_commons/widgets/animation/fade_in.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../utils/globals.dart';
import '../widgets/app_drawer.dart';
import '../widgets/operating/operating_floating_button.dart';
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
        const Text('Statistics'),
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
                      const _Logo(),
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
      floatingActionButton: const OperatingFloatingButton(),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: CircleAvatar(
        backgroundColor: Colors.black12,
        radius: 50,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              Globals.assetImgLogo,
              fit: BoxFit.cover,
            ),
          ),
        ),
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    if (!isLandscape) {
      return Column(
        children: [..._buildNavigationButtons()],
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [..._buildNavigationButtons()],
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
