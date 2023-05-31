import 'dart:math' as math;

import 'package:flutter/material.dart';

class IsometricBoxPainter extends CustomPainter {
  final gradientColors = <Color>[
    const Color(0xFFFFD060),
    const Color(0xFFD64DBD),
    const Color(0xFF9E00F6),
  ];

  void paintGradient(Canvas canvas, Path path, List<Color> colors, double gradientRotationDeg, {List<double>? stops}) {
    final LinearGradient gradient = LinearGradient(
      colors: colors,
      stops: stops,
      transform: GradientRotation(2 * math.pi * gradientRotationDeg / 360),
    );
    // rect is the area we are painting over
    final Paint paint = Paint()..shader = gradient.createShader(path.getBounds());
    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // print(size);

    _paintBox(canvas, size);
  }

  void _paintBox(Canvas canvas, Size size) {
    var height = size.height;
    var width = size.width;

    const double left = 0; // size.width * 0.0;
    final hCenter = width * 0.5;
    final right = width * 1.0;

    final top = _Point(hCenter, height * 0);
    final middle = _Point(hCenter, height * 0.44);
    final bottom = _Point(hCenter, height * 0.89);
    final topLeft = _Point(left, height * 0.22);
    final bottomLeft = _Point(left, height * 0.67);
    final topRight = _Point(right, height * 0.22);
    final bottomRight = _Point(right, height * 0.67);

    final topInner = _Point(hCenter, height * 0.17);
    final bottomInner = _Point(hCenter, height * 0.71);
    final topLeftInner = _Point(width * 0.2, height * 0.31);
    final bottomLeftInner = _Point(width * 0.2, height * 0.58);
    final topRightInner = _Point(width * 0.8, height * 0.31);
    final bottomRightInner = _Point(width * 0.8, height * 0.58);

    final outerBoxGradientColors = [gradientColors.first.withOpacity(0.8), gradientColors.last.withOpacity(0.8)];
    // 3 farben unterstuetzen
    if (gradientColors.length == 3) outerBoxGradientColors.insert(1, gradientColors[1].withOpacity(0.8));
    final innerBoxGradientColors = [gradientColors.first.withOpacity(0.8), gradientColors.last.withOpacity(0.5)];
    if (gradientColors.length == 3) innerBoxGradientColors.insert(1, gradientColors[1].withOpacity(0.65));

    final outerTopColors = [
      outerBoxGradientColors.first.withOpacity(0.9),
      outerBoxGradientColors.last.withOpacity(0.8)
    ];
    if (gradientColors.length == 3) outerTopColors.insert(1, gradientColors[1].withOpacity(0.85));

    final innerTopColors = [
      innerBoxGradientColors.first.withOpacity(0.9),
      innerBoxGradientColors.last.withOpacity(0.4)
    ];
    if (gradientColors.length == 3) innerTopColors.insert(1, gradientColors[1].withOpacity(0.65));

    _paintBoxWalls(canvas, outerBoxGradientColors, top, middle, bottom, topLeft, bottomLeft, topRight, bottomRight);

    _paintBoxWalls(canvas, innerBoxGradientColors, topInner, middle, bottomInner, topLeftInner, bottomLeftInner,
        topRightInner, bottomRightInner);

    _paintBoxTop(canvas, innerTopColors, topInner, middle, bottomInner, topLeftInner, bottomLeftInner, topRightInner,
        bottomRightInner);
    _paintBoxTop(canvas, outerTopColors, top, middle, bottom, topLeft, bottomLeft, topRight, bottomRight);

    final bottomBlur = _Point(hCenter, height * 1);
    final bottomLeftBlur = _Point(left, height * 0.78);
    final bottomRightBlur = _Point(right, height * 0.78);

    final blurGradientColors = [gradientColors.first.withOpacity(0.4), gradientColors.first.withOpacity(0.0)];

    final leftBlur = Path();
    leftBlur.moveTo(bottomLeft.x, bottomLeft.y);
    leftBlur.lineTo(bottom.x, bottom.y);
    leftBlur.lineTo(bottomBlur.x, bottomBlur.y);
    leftBlur.lineTo(bottomLeftBlur.x, bottomLeftBlur.y);
    leftBlur.close();
    paintGradient(canvas, leftBlur, blurGradientColors, 120, stops: [0.4, 0.6]);

    final rightBlur = Path();
    rightBlur.moveTo(bottomRight.x, bottomRight.y);
    rightBlur.lineTo(bottom.x, bottom.y);
    rightBlur.lineTo(bottomBlur.x, bottomBlur.y);
    rightBlur.lineTo(bottomRightBlur.x, bottomRightBlur.y);
    rightBlur.close();

    paintGradient(canvas, rightBlur, blurGradientColors, 60, stops: [0.4, 0.6]);
  }

  void _paintBoxWalls(Canvas canvas, List<Color> colors, _Point top, _Point middle, _Point bottom, _Point topLeft,
      _Point bottomLeft, _Point topRight, _Point bottomRight) {
    // Stops dyn. berechnen
    List<double>? stops;
    if (colors.length == 2) {
      stops = [0.0, 0.9];
    } else if (colors.length == 3) {
      stops = [0.0, 0.45, 0.9];
    }

    final leftWall = Path();
    leftWall.moveTo(topLeft.x, topLeft.y);
    leftWall.lineTo(middle.x, middle.y);
    leftWall.lineTo(bottom.x, bottom.y);
    leftWall.lineTo(bottomLeft.x, bottomLeft.y);
    leftWall.close();

    paintGradient(canvas, leftWall, colors, 300, stops: stops);

    final rightWall = Path();
    rightWall.moveTo(topRight.x, topRight.y);
    rightWall.lineTo(middle.x, middle.y);
    rightWall.lineTo(bottom.x, bottom.y);
    rightWall.lineTo(bottomRight.x, bottomRight.y);
    rightWall.close();

    paintGradient(canvas, rightWall, colors, 240, stops: stops);
  }

  void _paintBoxTop(Canvas canvas, List<Color> colors, _Point top, _Point middle, _Point bottom, _Point topLeft,
      _Point bottomLeft, _Point topRight, _Point bottomRight) {
    // Stops dyn. berechnen
    List<double>? stops;
    if (colors.length == 2) {
      stops = [0.25, 0.8];
    } else if (colors.length == 3) {
      stops = [0.25, 0.55, 0.8];
    }

    final topWall = Path();
    topWall.moveTo(top.x, top.y);
    topWall.lineTo(topLeft.x, topLeft.y);
    topWall.lineTo(middle.x, middle.y);
    topWall.lineTo(topRight.x, topRight.y);
    topWall.close();

    paintGradient(canvas, topWall, colors, 270, stops: stops);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _Point {
  final double x;
  final double y;

  _Point(this.x, this.y);
}
