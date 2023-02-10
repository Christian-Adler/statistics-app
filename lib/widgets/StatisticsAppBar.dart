import 'package:flutter/material.dart';

import 'ext/GradientAppBar.dart';

class StatisticsAppBar extends GradientAppBar {
  StatisticsAppBar(String title, BuildContext context, {super.key, List<Widget>? actions})
      : super(
          title: Text(title),
          gradientColors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
          actions: actions,
        );
}
