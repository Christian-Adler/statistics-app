import 'package:flutter/material.dart';
import 'package:flutter_commons/widgets/ext/gradient_app_bar.dart';
import 'package:provider/provider.dart';

import '../providers/dynamic_theme_data.dart';

class StatisticsAppBar extends GradientAppBar {
  StatisticsAppBar(
    Widget title,
    BuildContext context, {
    super.key,
    List<Widget>? actions,
    Color? actionsColor,
    bool automaticallyImplyLeading = true,
  }) : super(
          title: title,
          gradientColors: Provider.of<DynamicThemeData>(context).getActiveThemeColors().gradientColors,
          actions: actions,
          actionsColor: actionsColor,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
}
