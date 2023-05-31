import 'dart:math' as math;

import 'package:flutter/material.dart';

class IsometricBoxPainter extends CustomPainter {
  final gradientColors = <Color>[
    const Color(0xFFFFD060),
    const Color(0xFFD64DBD),
    const Color(0xFF9E00F6),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    _paintBox(canvas, size);
  }

  void _paintBox(Canvas canvas, Size size) {
    var height = size.height;
    var width = size.width;

    const double left = 0; // size.width * 0.0;
    final hCenter = width * 0.5;
    final right = width * 1.0;

    // y alles in abhaengigkeit von width berechnen
    // dann ist die Hoehe variabel - dann können verschieden hohe "Bars" erzeugt werden

    final top = _Point(hCenter, 0);
    final middle = _Point(hCenter, width * 0.58);
    final topLeft = _Point(left, width * 0.29);
    final topRight = _Point(right, width * 0.29);
    final bottom = _Point(hCenter, height - width * 0.15);
    final bottomLeft = _Point(left, height - width * 0.44);
    final bottomRight = _Point(right, height - width * 0.44);

    final topInner = _Point(hCenter, width * 0.22);
    final topLeftInner = _Point(width * 0.2, width * 0.40);
    final topRightInner = _Point(width * 0.8, width * 0.40);
    final bottomInner = _Point(hCenter, height - width * 0.37);
    final bottomLeftInner = _Point(width * 0.2, height - width * 0.55);
    final bottomRightInner = _Point(width * 0.8, height - width * 0.55);

    final outerBoxGradientColors = [gradientColors.first.withOpacity(0.8), gradientColors.last.withOpacity(0.8)];
    // 3 farben unterstuetzen
    if (gradientColors.length == 3) outerBoxGradientColors.insert(1, gradientColors[1].withOpacity(0.8));
    final outerBoxGradientColorsLeft = [gradientColors.first.withOpacity(0.8), gradientColors.last.withOpacity(0.6)];
    if (gradientColors.length == 3) outerBoxGradientColorsLeft.insert(1, gradientColors[1].withOpacity(0.7));

    final innerBoxGradientColors = [gradientColors.first.withOpacity(0.8), gradientColors.last.withOpacity(0.5)];
    if (gradientColors.length == 3) innerBoxGradientColors.insert(1, gradientColors[1].withOpacity(0.65));
    final innerBoxGradientColorsLeft = [gradientColors.first.withOpacity(0.7), gradientColors.last.withOpacity(0.4)];
    if (gradientColors.length == 3) innerBoxGradientColorsLeft.insert(1, gradientColors[1].withOpacity(0.55));

    final outerTopColors = [gradientColors.first.withOpacity(0.7), gradientColors.last.withOpacity(0.7)];
    if (gradientColors.length == 3) outerTopColors.insert(1, gradientColors[1].withOpacity(0.7));

    final innerTopColors = [gradientColors.first.withOpacity(0.2), gradientColors.last.withOpacity(0.2)];
    if (gradientColors.length == 3) innerTopColors.insert(1, gradientColors[1].withOpacity(0.2));

    _paintBoxWalls(canvas, outerBoxGradientColors, middle, bottom, topLeft, bottomLeft, topRight, bottomRight,
        colorsLeftWall: outerBoxGradientColorsLeft);

    _paintBoxWalls(canvas, innerBoxGradientColors, middle, bottomInner, topLeftInner, bottomLeftInner, topRightInner,
        bottomRightInner,
        colorsLeftWall: innerBoxGradientColorsLeft);

    _paintBoxTop(canvas, innerTopColors, topInner, middle, bottomInner, topLeftInner, bottomLeftInner, topRightInner,
        bottomRightInner);
    _paintBoxTop(canvas, outerTopColors, top, middle, bottom, topLeft, bottomLeft, topRight, bottomRight);

    final bottomBlur = _Point(hCenter, height);
    final bottomLeftBlur = _Point(left, height - width * 0.29);
    final bottomRightBlur = _Point(right, height - width * 0.29);

    final blurGradientColors = [gradientColors.first.withOpacity(0.0), gradientColors.first.withOpacity(0.6)];

    _paintBoxWalls(
        canvas, blurGradientColors, bottom, bottomBlur, bottomLeft, bottomLeftBlur, bottomRight, bottomRightBlur);
  }

  void _paintBoxWalls(Canvas canvas, List<Color> colors, _Point middle, _Point bottom, _Point topLeft,
      _Point bottomLeft, _Point topRight, _Point bottomRight,
      {List<Color>? colorsLeftWall}) {
    // Stops dyn. berechnen
    List<double>? stops;
    if (colors.length == 2) {
      stops = [0.0, 1];
    } else if (colors.length == 3) {
      stops = [0.0, 0.3, 1.0];
    }

    final leftWall = Path();
    leftWall.moveTo(topLeft.x, topLeft.y);
    leftWall.lineTo(middle.x, middle.y);
    leftWall.lineTo(bottom.x, bottom.y);
    leftWall.lineTo(bottomLeft.x, bottomLeft.y);
    leftWall.close();

    final rightWall = Path();
    rightWall.moveTo(topRight.x, topRight.y);
    rightWall.lineTo(middle.x, middle.y);
    rightWall.lineTo(bottom.x, bottom.y);
    rightWall.lineTo(bottomRight.x, bottomRight.y);
    rightWall.close();

    // Berechne Gradient-Alignment senkrecht zur unteren Kante des Parallelograms
    final w = middle.x - topLeft.x;
    final h = bottom.y - topLeft.y;
    final c = bottomLeft.y - topLeft.y;
    final c_ = bottom.y - bottomLeft.y;
    final alpha = math.atan2(c_, w);

    final a = c * math.sin(alpha);
    final b = c * math.cos(alpha);
    final p = a * a / c;
    final q = c - p;
    final x = math.sqrt(p * q);
    final y = c - b;

    final colorsLeft = colorsLeftWall ?? colors;
    paintGradient(
        canvas, leftWall, colorsLeft, Alignment(-1, -1 + 2 * c / h), Alignment(-1 + 2 * x / w, -1 + 2 * y / h),
        stops: stops);

    paintGradient(canvas, rightWall, colors, Alignment(1, -1 + 2 * c / h), Alignment(1 - 2 * x / w, -1 + 2 * y / h),
        stops: stops);
  }

  void _paintBoxTop(Canvas canvas, List<Color> colors, _Point top, _Point middle, _Point bottom, _Point topLeft,
      _Point bottomLeft, _Point topRight, _Point bottomRight) {
    // Stops dyn. berechnen
    List<double>? stops;
    if (colors.length == 2) {
      stops = [0.0, 1.0];
    } else if (colors.length == 3) {
      stops = [0.0, 0.6, 1.0];
    }

    final topWall = Path();
    topWall.moveTo(top.x, top.y);
    topWall.lineTo(topLeft.x, topLeft.y);
    topWall.lineTo(middle.x, middle.y);
    topWall.lineTo(topRight.x, topRight.y);
    topWall.close();

    paintGradient(canvas, topWall, colors, const Alignment(0, 0.9), const Alignment(0, -0.7), stops: stops);
  }

  void paintGradient(Canvas canvas, Path path, List<Color> colors, AlignmentGeometry begin, AlignmentGeometry end,
      {List<double>? stops}) {
    final LinearGradient gradient = LinearGradient(
      colors: colors,
      stops: stops,
      begin: begin,
      end: end,
    );
    final Paint paint = Paint()..shader = gradient.createShader(path.getBounds());
    canvas.drawPath(path, paint);
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
