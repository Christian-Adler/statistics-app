import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/navigation/screen_nav_info.dart';
import '../../providers/main_navigation.dart';
import 'utils/isometric_box_painter.dart';

class OverviewIsometricNavigationButton extends StatelessWidget {
  const OverviewIsometricNavigationButton({super.key, required this.edgeColors, required this.screenNavInfo});

  final ScreenNavInfo screenNavInfo;
  final List<Color> edgeColors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            width: (200 * 5 / 7).truncateToDouble(),
            bottom: 0,
            child: CustomPaint(painter: IsometricBoxPainter()),
          ),
          // Positioned(
          //   top: 2,
          //   right: 2,
          //   width: 218,
          //   height: 98,
          //   child: _ColoredIconButton(
          //       screenNavInfo.routeName, screenNavInfo.title, screenNavInfo.iconData, edgeColors[0], edgeColors[1]),
          // ),
        ],
      ),
    );
  }
}

class _ColoredIconButton extends StatelessWidget {
  final String text;
  final String routeName;
  final IconData iconData;
  final Color color;
  final Color color2;

  const _ColoredIconButton(
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
      onPressed: () {
        Provider.of<MainNavigation>(context, listen: false).mainPageRoute = routeName;
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
