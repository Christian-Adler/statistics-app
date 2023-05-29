import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../utils/globals.dart';
import '../layout/single_child_scroll_view_with_scrollbar.dart';
import 'overview_footer.dart';
import 'overview_navigation_buttons.dart';

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
    if (mediaQueryInfo.isTablet && mediaQueryInfo.isLandscape) {
      return const Parallax();
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

class Parallax extends StatefulWidget {
  const Parallax({
    super.key,
  });

  @override
  State<Parallax> createState() => _ParallaxState();
}

class _ParallaxState extends State<Parallax> {
  List<double>? _accelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  int buttonsMotionSensitivity = 4;
  int bgMotionSensitivity = 2;

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text("It seems that your device doesn't support Gyroscope Sensor"),
                );
              });
        },
        cancelOnError: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accelerometer = _accelerometerValues;
    double x = 0;
    double y = 0;
    // double z = 0;
    if (accelerometer != null) {
      x = accelerometer.elementAt(0);
      y = accelerometer.elementAt(1) - 9.81;
      // z = accelerometer.elementAt(2);
    }
    // print(x);
    // print(y);
    // print(z);
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          top: y * bgMotionSensitivity,
          bottom: y * -bgMotionSensitivity,
          right: x * -bgMotionSensitivity,
          left: x * bgMotionSensitivity,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Globals.assetImgBackground,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          top: y * buttonsMotionSensitivity,
          bottom: y * -buttonsMotionSensitivity,
          right: x * -buttonsMotionSensitivity,
          left: x * buttonsMotionSensitivity,
          child: const Center(
            child: SingleChildScrollViewWithScrollbar(
              // No BottomNavBar hide on Overview Screen // scrollDirectionCallback: HideBottomNavigationBar.setScrollDirection,
              child: Center(child: OverviewNavigationButtons()),
            ),
          ),
        ),
      ],
    );
  }
}
