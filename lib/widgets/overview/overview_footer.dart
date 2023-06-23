import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../providers/dynamic_theme_data.dart';

class OverviewFooter extends StatelessWidget {
  const OverviewFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeThemeColors = Provider.of<DynamicThemeData>(context).getActiveThemeColors();

    return Container(
      height: 44,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: activeThemeColors.gradientColors),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Icon(
            Icons.alternate_email,
            color: activeThemeColors.onGradientColor,
          ),
          const SizedBox(width: 10),
          Text(
            Provider.of<Auth>(context, listen: false).serverUrl,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: activeThemeColors.onGradientColor,
            ),
          ),
        ],
      ),
    );
  }
}
