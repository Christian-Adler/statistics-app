import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:statistics/utils/color_utils.dart';
import 'package:statistics/utils/date_utils.dart';

import '../models/chart/chart_meta_data.dart';

class Charts {
  static LineTouchData _createLineTouchData({
    int fractionDigits = 2,
  }) {
    return LineTouchData(
      enabled: true,
      touchSpotThreshold: 30,
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
        fitInsideHorizontally: true,
        fitInsideVertically: true,
        tooltipBgColor: Colors.white70,
        tooltipBorder: const BorderSide(
          color: Colors.black26,
          width: 2,
        ),
        getTooltipItems: (touchedSpots) {
          // alles wie default, nur y-Wert gerundet auf 2 Stellen
          return touchedSpots.map((touchedSpot) {
            final textStyle = TextStyle(
              color: touchedSpot.bar.gradient?.colors.first ?? touchedSpot.bar.color ?? Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              // backgroundColor: Colors.grey,
              shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
            );
            return LineTooltipItem(touchedSpot.y.toStringAsFixed(fractionDigits), textStyle);
          }).toList();
        },
      ),
      getTouchedSpotIndicator: Charts._createTouchedSpotIndicators,
    );
  }

  static List<TouchedSpotIndicatorData?> _createTouchedSpotIndicators(barData, spotIndexes) {
    List<TouchedSpotIndicatorData?> result = [];
    for (var _ in spotIndexes) {
      result.add(TouchedSpotIndicatorData(
        FlLine(
          color: Colors.grey,
          strokeWidth: 2,
        ),
        FlDotData(
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
              radius: 4,
              color: Colors.white70,
              strokeWidth: 2,
              strokeColor: Colors.grey,
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

  static Widget _createTitlesBottom(
    double value,
    TitleMeta meta,
    ChartMetaData chartMeta,
  ) {
    if (value % 1 != 0) {
      return Container();
    }

    Widget child;
    if (chartMeta.yearly) {
      child = Text(value.toInt().toString());
    } else {
      var month = (value.toInt() % 12);
      if (chartMeta.showYearOnJan && month == 1) {
        var year = ((value - month) ~/ 12);
        child = Column(
          children: [
            Text(DateUtil.getMonthShort(month)),
            Text(year.toString()),
          ],
        );
      } else {
        child = Text(DateUtil.getMonthShort(month));
      }
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: child,
      // child: Text(meta.formattedValue, style: style),
    );
  }

  static FlTitlesData _createTitlesData(ChartMetaData chartMeta) {
    return FlTitlesData(
      leftTitles: AxisTitles(
        // axisNameWidget: const Text(
        //   'Value',
        // ),
        sideTitles: SideTitles(
          showTitles: true,
          // interval: 2, // dynamisch
          getTitlesWidget: (value, meta) => _createTitlesLeft(value, meta),
          reservedSize: 40,
        ),
        drawBehindEverything: true,
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => _createTitlesBottom(value, meta, chartMeta),
          reservedSize:
              // Monatsanzeige und Jahreszahl? Dann mehr Platz
              !chartMeta.yearly && chartMeta.showYearOnJan ? 36 : 20,
          // interval: 1,
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
      show: false,
      drawVerticalLine: true,
      drawHorizontalLine: true,
    );
  }

  static FlDotData _createDotData(ChartMetaData? chartMetaData) {
    return FlDotData(
      show: chartMetaData?.showDots ?? false,
      getDotPainter: (spot, xPercentage, lineChartBardata, index) {
        var color = lineChartBardata.gradient?.colors.first ?? lineChartBardata.color ?? Colors.blueGrey;
        return FlDotCirclePainter(
          color: color,
          radius: 3,
          strokeWidth: 1,
          strokeColor: ColorUtils.hue(color, 30), // Colors.white,
        );
      },
    );
  }

  static Shadow _createLineShadow() {
    return const Shadow(color: Colors.black26, offset: Offset(5, 5));
  }

  static LinearGradient? createTopToBottomGradient(List<Color>? gradientColors) {
    if (gradientColors == null) return null;
    return LinearGradient(
      colors: gradientColors,
      // stops:  [0.0, 1.0], // ohne angabe dyn. verteilt
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static LineChartBarData createLineChartBarData(
    List<FlSpot>? spots,
    List<Color> gradientColors, {
    shadow = false,
    double? barWidth = 4,
    List<Color>? fillColors,
    List<int>? dashArray,
    ChartMetaData? chartMetaData,
  }) {
    return LineChartBarData(
      // spots: [ FlSpot(1, 0.5), FlSpot(2, 0.7), ],
      spots: spots,
      dotData: Charts._createDotData(chartMetaData),
      dashArray: dashArray,
      gradient: Charts.createTopToBottomGradient(gradientColors),
      belowBarData: BarAreaData(
        show: fillColors != null,
        gradient: createTopToBottomGradient(fillColors),
      ),
      barWidth: barWidth,
      isCurved: true,
      preventCurveOverShooting: true,
      // curveSmoothness: 0.5,
      shadow: shadow ? Charts._createLineShadow() : null,
      isStrokeCapRound: true,
    );
  }

  static LineChart createLineChartData(
    ChartMetaData chartMeta,
    List<LineChartBarData>? lineBarsData, {
    int fractionDigits = 2,
  }) {
    return LineChart(
      LineChartData(
        minY: chartMeta.yMin,
        maxY: chartMeta.yMax,
        minX: chartMeta.xMin,
        maxX: chartMeta.xMax,
        lineTouchData: Charts._createLineTouchData(fractionDigits: fractionDigits),
        clipData: FlClipData.all(),
        gridData: Charts._createGridData(),
        borderData: Charts._createBorderData(),
        lineBarsData: lineBarsData,
        titlesData: Charts._createTitlesData(chartMeta),
      ),
    );
  }

  static Widget createChartContainer(Widget? chart, Orientation orientation) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: orientation == Orientation.portrait ? 3 / 2 : 3 / 1,
        child: chart,
      ),
    );
  }
}
