import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/hide_bottom_navigation_bar.dart';
import 'package:flutter_commons/utils/media_query_utils.dart';
import 'package:flutter_commons/widgets/layout/single_child_scroll_view_with_scrollbar.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../utils/global_keys.dart';
import '../../../utils/globals.dart';
import '../overview_navigation_buttons.dart';

class OverviewParallax extends StatefulWidget {
  const OverviewParallax({
    super.key,
    required this.darkMode,
  });

  final bool darkMode;

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

  final List<Color> _bar1DefaultColors = [];
  final _bar1HighlightColors = [
    const Color.fromRGBO(249, 201, 77, 1),
    const Color.fromRGBO(250, 126, 92, 1),
    const Color.fromRGBO(232, 54, 149, 1),
    const Color.fromRGBO(109, 25, 134, 1),
  ];
  final List<Color> _bar2DefaultColors = [];
  final _bar2HighlightColors = [
    const Color.fromRGBO(201, 255, 254, 1),
    const Color.fromRGBO(51, 212, 232, 1),
    const Color.fromRGBO(73, 255, 255, 1),
    const Color.fromRGBO(48, 173, 230, 1),
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

    _bar1DefaultColors.addAll(widget.darkMode ? [Colors.white24, Colors.white12] : [Colors.black26, Colors.black12]);
    _bar2DefaultColors.addAll(widget.darkMode ? [Colors.white54, Colors.white24] : [Colors.black54, Colors.black26]);

    // Alle Farblisten am Anfang und Ende mit der entsprechenden transparenten Farbe erweitern
    final colorLists = [_bar1DefaultColors, _bar2DefaultColors, _bar1HighlightColors, _bar2HighlightColors];
    for (var barColorList in colorLists) {
      barColorList.insert(0, barColorList.first.withOpacity(0));
      barColorList.add(barColorList.last.withOpacity(0));
    }

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

    final mediaQueryUtils = MediaQueryUtils.of(context);

    final accelerometer = _accelerometerValues;
    double xRot = 0;
    double yRot = 0;
    // double z = 0;
    if (accelerometer != null) {
      if (mediaQueryUtils.isLandscape) {
        // accelerometer achsen vertauschen
        yRot = accelerometer.elementAt(0);
        xRot = accelerometer.elementAt(1); //- 9.81;
        // z = accelerometer.elementAt(2);
      } else {
        xRot = accelerometer.elementAt(0);
        yRot = accelerometer.elementAt(1); //- 9.81;
        // z = accelerometer.elementAt(2);
      }
    }
    // print(xRot);
    // print(yRot);
    // print(z);

    // Navigation Buttons - bei Tablet zentriert
    Widget navButtons = const SingleChildScrollViewWithScrollbar(
      scrollPositionHandler: HideBottomNavigationBar.setScrollPosition,
      child: Center(child: OverviewNavigationButtons()),
    );
    if (mediaQueryUtils.isTablet) {
      navButtons = AnimatedPositioned(
        duration: const Duration(milliseconds: 250),
        top: yRot * 2 * _motionSensitivityButtons,
        bottom: yRot * 2 * -_motionSensitivityButtons,
        right: xRot * -_motionSensitivityButtons,
        left: xRot * _motionSensitivityButtons,
        child: Center(
          child: navButtons,
        ),
      );
    }

    return Stack(
      children: [
        ..._buildBars(xRot, yRot, _bar1Width, _bar1SeparatorWidth, _motionSensitivityBars1, _bars1, _bar1DefaultColors,
            [3, 11], _bar1HighlightColors),
        ..._buildBars(xRot, yRot, _bar2Width, _bar2SeparatorWidth, _motionSensitivityBars2, _bars2, _bar2DefaultColors,
            [3, 4, 8, 11, 12], _bar2HighlightColors),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          height: 2,
          bottom: yRot * -_motionSensitivityLogo + _widgetSize.height / 2,
          left: xRot * _motionSensitivityLogo + _widgetSize.width * 0.05,
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
          top: yRot * _motionSensitivityLogo,
          bottom: yRot * -_motionSensitivityLogo,
          right: xRot * -_motionSensitivityLogo,
          left: xRot * _motionSensitivityLogo,
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
        navButtons,
      ],
    );
  }
}

class _BarItem {
  final double heightFactor;
  final double yOffsetFactor;

  _BarItem(this.heightFactor, this.yOffsetFactor);
}
