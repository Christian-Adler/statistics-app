import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../utils/color_utils.dart';

class OverviewFooter extends StatelessWidget {
  const OverviewFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        gradient: ColorUtils.getThemeLinearGradient(context),
        color: ColorUtils.getThemeOnGradientColor(context),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          const Icon(
            Icons.alternate_email,
          ),
          const SizedBox(width: 10),
          Text(
            Provider.of<Auth>(context, listen: false).serverUrl,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
