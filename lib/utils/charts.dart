import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../providers/operating.dart';
import 'globals.dart';

class Charts {
  static LineTouchData _createLineTouchData() {
    return LineTouchData(
      enabled: true,
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
        fitInsideHorizontally: true,
        fitInsideVertically: true,
        tooltipBgColor: Colors.white70,
        tooltipBorder: const BorderSide(
          color: Colors.black26,
          width: 2,
        ),
      ),
      getTouchedSpotIndicator: Charts._createTouchedSpotIndicators,
    );
  }

  static List<TouchedSpotIndicatorData?> _createTouchedSpotIndicators(barData, spotIndexes) {
    List<TouchedSpotIndicatorData?> result = [];
    for (var _ in spotIndexes) {
      result.add(TouchedSpotIndicatorData(
        FlLine(
          color: Colors.red,
          strokeWidth: 2,
        ),
        FlDotData(
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
              radius: 4,
              color: Colors.transparent,
              strokeWidth: 2,
              strokeColor: Colors.red,
            );
          },
        ),
      ));
    }
    return result;
  }

  static Widget _createTitlesLeft(double value, TitleMeta meta) {
    // if (value % 1 != 0) { // nur ganzzahlig anzeigen
    //   return Container();
    // }
    if (value % 2 != 0) {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(meta.formattedValue),
    );
  }

  static Widget _createTitlesBottomMonthly(double value, TitleMeta meta) {
    if (value % 1 != 0) {
      return Container();
    }

    var month = (value.toInt() % 12);
    if (month == 0) month = 12;

    Widget child;
    if (month == 1) {
      child = Column(
        children: [
          Text(Globals.getMonthShort(month)),
          Text(((value - month) ~/ 12).toString()),
        ],
      );
    } else {
      child = Text(Globals.getMonthShort(month));
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: child,
      // child: Text(meta.formattedValue, style: style),
    );
  }

  static FlTitlesData _createTitlesDataMonthly() {
    return FlTitlesData(
      leftTitles: AxisTitles(
        // axisNameWidget: const Text(
        //   'Value',
        // ),
        sideTitles: SideTitles(
          showTitles: true,
          interval: 2,
          getTitlesWidget: (value, meta) => _createTitlesLeft(value, meta),
          reservedSize: 30,
        ),
        drawBehindEverything: true,
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => _createTitlesBottomMonthly(value, meta),
          reservedSize: 50,
          interval: 1,
        ),
        drawBehindEverything: true,
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  static FlBorderData _createBorderData() {
    return FlBorderData(
      show: true,
      border: Border(
        bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        left: const BorderSide(color: Colors.transparent),
        right: const BorderSide(color: Colors.transparent),
        top: const BorderSide(color: Colors.transparent),
      ),
    );
  }

  static FlGridData _createGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
    );
  }

  static FlDotData _createDotData() {
    return FlDotData(
      show: false,
      // getDotPainter: (p0, p1, p2, p3) {
      //   return FlDotCirclePainter(
      //     color: Colors.red,
      //     radius: 4,
      //     strokeWidth: 0,
      //   );
      // },
    );
  }

  static Shadow _createLineShadow() {
    return const Shadow(color: Colors.black26, offset: Offset(5, 5));
  }

  static LinearGradient _createTopToBottomGradient(List<Color> gradientColors) {
    return LinearGradient(
      colors: gradientColors,
      stops: const [0.0, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static LineChartBarData createLineChartBarData(List<FlSpot>? spots, List<Color> gradientColors) {
    return LineChartBarData(
      // spots: [ FlSpot(1, 0.5), FlSpot(2, 0.7), ],
      spots: spots,
      dotData: Charts._createDotData(),
      gradient: Charts._createTopToBottomGradient(gradientColors),
      // belowBarData: BarAreaData(
      //   show: true,
      //   gradient: LinearGradient(
      //     colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
      //     stops: const [0.0, 1.0],
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //   ),
      // ),
      barWidth: 4,
      isCurved: true,
      preventCurveOverShooting: true,
      // curveSmoothness: 0.5,
      shadow: Charts._createLineShadow(),
      isStrokeCapRound: true,
    );
  }

  static LineChart createLineChartMonthlyData(ChartMetaData chartMeta, List<LineChartBarData>? lineBarsData) {
    return LineChart(
      LineChartData(
        minY: chartMeta.yMin,
        maxY: chartMeta.yMax,
        minX: chartMeta.xMin,
        maxX: chartMeta.xMax,
        lineTouchData: Charts._createLineTouchData(),
        clipData: FlClipData.all(),
        gridData: Charts._createGridData(),
        borderData: Charts._createBorderData(),
        lineBarsData: lineBarsData,
        titlesData: Charts._createTitlesDataMonthly(),
      ),
    );
  }

  static Widget createChartContainer(Widget? chart, Orientation orientation) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: orientation == Orientation.portrait ? 3 / 2 : 3 / 1,
        child: Padding(padding: const EdgeInsets.all(10), child: chart),
      ),
    );
  }
}
