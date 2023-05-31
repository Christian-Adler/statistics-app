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
      // height: 300,
      height: 205,
      child: InkWell(
        onTap: () {
          Provider.of<MainNavigation>(context, listen: false).mainPageRoute = screenNavInfo.routeName;
        },
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        splashColor: edgeColors.last.withOpacity(0.3),
        child: Stack(
          children: [
            Positioned(
              top: 5,
              left: 25,
              width: (200 * 5 / 7).truncateToDouble(),
              bottom: 0,
              child: CustomPaint(
                painter: IsometricBoxPainter(
                  // [const Color(0xFFFFD060),const Color(0xFFD64DBD),const Color(0xFF9E00F6),],
                  edgeColors,
                ),
              ),
            ),
            Positioned(
              top: 39 + 5,
              left: 19 + 25,
              width: 56,
              height: 56,
              child: Transform(
                transform: Matrix4.rotationZ(-0.52),
                child: Transform(
                  transform: Matrix4.skewX(0.52),
                  child: Icon(
                    screenNavInfo.iconData,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 90 + 5,
              left: 90 + 25,
              width: 150,
              height: 45,
              child: Transform(
                transform: Matrix4.skewY(-0.52),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        border: Border(
                          right: BorderSide(
                            color: edgeColors.first,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(screenNavInfo.title, style: TextStyle(color: edgeColors.first, fontSize: 20)),
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [edgeColors.last.withOpacity(0), edgeColors.first]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
