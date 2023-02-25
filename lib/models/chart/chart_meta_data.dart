class ChartMetaData {
  double _xMin = double.maxFinite;
  double _xMax = (double.maxFinite - 1) * -1;
  double _yMin = double.maxFinite;
  double _yMax = (double.maxFinite - 1) * -1;

  double _xPadding = 0;
  double _yPadding = 0;

  /// Jahres-Werte?
  bool yearly = false;

  void put(num xVal, num yVal) {
    putAll(xVal, [yVal]);
  }

  void putAll(num xVal, List<num> yValues) {
    if (xVal < _xMin) _xMin = xVal.toDouble();
    if (xVal > _xMax) _xMax = xVal.toDouble();
    for (var yVal in yValues) {
      if (yVal < _yMin) _yMin = yVal.toDouble();
      if (yVal > _yMax) _yMax = yVal.toDouble();
    }
  }

  void calcPadding() {
    _xPadding = (_xMax - _xMin).abs() / 20;
    _yPadding = (_yMax - _yMin).abs() / 10;
  }

  double get xMin {
    return _xMin - _xPadding;
  }

  double get xMax {
    return _xMax + _xPadding;
  }

  double get yMin {
    if (_yMin >= 0 && _yMin < _yPadding) return 0;
    return _yMin - _yPadding;
  }

  double get yMax {
    return _yMax + _yPadding;
  }
}
