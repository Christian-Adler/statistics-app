import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../utils/global_keys.dart';
import '../../../utils/globals.dart';
import '../../layout/single_child_scroll_view_with_scrollbar.dart';
import '../overview_navigation_buttons.dart';

class OverviewParallax extends StatefulWidget {
  const OverviewParallax({
    super.key,
  });

  @override
  State<OverviewParallax> createState() => _OverviewParallaxState();
}

class _OverviewParallaxState extends State<OverviewParallax> {
  List<double>? _accelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  Size _widgetSize = const Size(0, 0);

  final _random = Random();

  final int _motionSensitivityButtons = 4;
  final int _motionSensitivityLogo = 3;
  final int _motionSensitivityBars1 = 1;
  final int _motionSensitivityBars2 = 2;

  // Random bars
  final double _bar1Width = 65;
  final double _bar1SeparatorWidth = 1;
  final double _bar2Width = 18;
  final double _bar2SeparatorWidth = 83;

  final _bar1DefaultColors = [
    Colors.transparent,
    Colors.black26,
    Colors.black12,
    Colors.transparent,
  ];
  final _bar1HighlightColors = [
    Colors.amber.withOpacity(0),
    Colors.amber,
    Colors.purpleAccent,
    Colors.purple,
    Colors.purple.withOpacity(0),
  ];
  final _bar2DefaultColors = [
    Colors.transparent,
    Colors.black54,
    Colors.black26,
    Colors.transparent,
  ];
  final _bar2HighlightColors = [
    const Color.fromRGBO(201, 255, 254, 0),
    const Color.fromRGBO(201, 255, 254, 1),
    const Color.fromRGBO(51, 212, 232, 1),
    const Color.fromRGBO(73, 255, 255, 1),
    const Color.fromRGBO(48, 173, 230, 1),
    const Color.fromRGBO(48, 173, 230, 0),
  ];

  List<_BarItem> _bars1 = [];
  List<_BarItem> _bars2 = [];

  double _doubleInRange(num start, num end) => _random.nextDouble() * (end - start) + start;

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

  List<AnimatedPositioned> _buildBars(
      double xRot,
      double yRot,
      double barWidth,
      double barSeparatorWidth,
      int motionSensitivity,
      List<_BarItem> bars,
      List<Color> barColors,
      List<int> highlights,
      List<Color> highLightBarColors) {
    List<AnimatedPositioned> result = [];
    for (var i = 0; i < bars.length; ++i) {
      var barItem = bars[i];

      var colors = barColors;
      if (highlights.contains(i)) {
        colors = highLightBarColors;
      }

      final barHeight = barItem.heightFactor * _widgetSize.height;

      result.add(AnimatedPositioned(
        duration: const Duration(milliseconds: 250),
        height: barHeight,
        bottom: yRot * -motionSensitivity * (2 * (1 - barItem.heightFactor)) +
            _widgetSize.height * barItem.yOffsetFactor -
            barHeight / 2 +
            _widgetSize.height / 2,
        left: xRot * motionSensitivity + (i - 1) * (barWidth + barSeparatorWidth),
        width: barWidth,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
            ),
          ),
        ),
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final widgetContext = GlobalKeys.overviewParallaxKey.currentContext;
    if (widgetContext != null) {
      var renderObject = widgetContext.findRenderObject();
      if (renderObject != null && renderObject is RenderBox) {
        final renderBox = renderObject;
        var size = renderBox.size;

        // Neu berechnen?
        if (size != _widgetSize) {
          double width = size.width;

          final numBars1 = width ~/ (_bar1Width + _bar1SeparatorWidth) + 2;
          final numBars2 = width ~/ (_bar2Width + _bar2SeparatorWidth) + 2;

          List<_BarItem> bars1 = [];
          for (var i = 0; i < numBars1; ++i) {
            var heightFactor = _doubleInRange(0.1, 0.5);
            var yOffsetFactor = _doubleInRange(-0.1, 0.1);
            bars1.add(_BarItem(heightFactor, yOffsetFactor));
          }
          List<_BarItem> bars2 = [];
          for (var i = 0; i < numBars2; ++i) {
            var heightFactor = _doubleInRange(0.4, 0.8);
            var yOffsetFactor = _doubleInRange(-0.1, 0.1);
            bars2.add(_BarItem(heightFactor, yOffsetFactor));
          }

          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              setState(() {
                _widgetSize = size;
                _bars1 = bars1;
                _bars2 = bars2;
              });
            },
          );
        }
      }
    }

    final accelerometer = _accelerometerValues;
    double x = 0;
    double y = 0;
    // double z = 0;
    if (accelerometer != null) {
      y = accelerometer.elementAt(0);
      x = accelerometer.elementAt(1); //- 9.81;
      // z = accelerometer.elementAt(2);
    }
    // print(x);
    // print(y);
    // print(z);

    return Stack(
      children: [
        ..._buildBars(x, y, _bar1Width, _bar1SeparatorWidth, _motionSensitivityBars1, _bars1, _bar1DefaultColors,
            [3, 11], _bar1HighlightColors),
        ..._buildBars(x, y, _bar2Width, _bar2SeparatorWidth, _motionSensitivityBars2, _bars2, _bar2DefaultColors,
            [3, 4, 8, 11, 12], _bar2HighlightColors),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          height: 2,
          bottom: y * -_motionSensitivityLogo + _widgetSize.height / 2,
          left: x * _motionSensitivityLogo + _widgetSize.width * 0.05,
          width: _widgetSize.width * 0.9,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.withOpacity(0),
                  Colors.deepPurple,
                  Colors.purple,
                  Colors.purple.withOpacity(0)
                ],
                begin: AlignmentDirectional.centerStart,
                end: AlignmentDirectional.centerEnd,
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          top: y * _motionSensitivityLogo,
          bottom: y * -_motionSensitivityLogo,
          right: x * -_motionSensitivityLogo,
          left: x * _motionSensitivityLogo,
          child: SizedBox(
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
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          top: y * 2 * _motionSensitivityButtons,
          bottom: y * 2 * -_motionSensitivityButtons,
          right: x * -_motionSensitivityButtons,
          left: x * _motionSensitivityButtons,
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

class _BarItem {
  final double heightFactor;
  final double yOffsetFactor;

  _BarItem(this.heightFactor, this.yOffsetFactor);
}
