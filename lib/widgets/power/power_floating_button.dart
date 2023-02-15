import 'package:flutter/material.dart';

import '../expandable/expandable_fab.dart';

class PowerFloatingButton extends StatelessWidget {
  const PowerFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 100.0,
      maxAngle: 70,
      startAngle: 10,
      children: [
        ActionButton(
          onPressed: () {},
          icon: const Icon(Icons.solar_power_outlined),
        ),
        ActionButton(
          onPressed: () {},
          icon: const Icon(Icons.power_input_outlined),
        ),
      ],
    );
  }
}
