import 'package:flutter/material.dart';

class StyleUtils {
  static BorderRadius buildBorderRadius(double topLeft, double topRight, double bottomLeft, double bottomRight) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight),
    );
  }
}
