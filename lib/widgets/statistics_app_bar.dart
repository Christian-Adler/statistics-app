import 'package:flutter/material.dart';
import 'package:flutter_commons/widgets/ext/gradient_app_bar.dart';

import '../utils/color_utils.dart';

class StatisticsAppBar extends GradientAppBar {
  StatisticsAppBar(
    Widget title,
    BuildContext context, {
    super.key,
    List<Widget>? actions,
    bool automaticallyImplyLeading = true,
  }) : super(
          title: title,
          gradientColors: ColorUtils.getThemeGradientColors(context),
          actions: actions,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
}
