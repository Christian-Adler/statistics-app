import 'package:flutter/material.dart';
import 'package:flutter_commons/widgets/ext/gradient_app_bar.dart';

class StatisticsAppBar extends GradientAppBar {
  StatisticsAppBar(
    Widget title,
    BuildContext context, {
    super.key,
    List<Widget>? actions,
    bool automaticallyImplyLeading = true,
  }) : super(
          title: title,
          gradientColors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
          actions: actions,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
}
