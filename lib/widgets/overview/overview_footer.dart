import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../utils/color_utils.dart';

class OverviewFooter extends StatelessWidget {
  const OverviewFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onGradientColor = ColorUtils.getThemeOnGradientColor(context);
    return Container(
      height: 44,
      decoration: BoxDecoration(
        gradient: ColorUtils.getThemeLinearGradient(context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Icon(
            Icons.alternate_email,
            color: onGradientColor,
          ),
          const SizedBox(width: 10),
          Text(
            Provider.of<Auth>(context, listen: false).serverUrl,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: onGradientColor,
            ),
          ),
        ],
      ),
    );
  }
}
