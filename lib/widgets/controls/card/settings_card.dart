import 'package:flutter/material.dart';

import '../../responsive/device_dependent_constrained_box.dart';

class SettingsCard extends StatelessWidget {
  final dynamic title;
  final List<Widget> children;

  /// Damit die Card die Device-Constraints einhalten kann, muss umschliessende Column z.B. center sein.
  const SettingsCard({Key? key, required this.title, required this.children}) : super(key: key);

  Widget _buildTitle(BuildContext context) {
    if (title is Widget) return title as Widget;
    var titleText = 'Titel';
    if (title is String) titleText = title as String;
    return Text(titleText, style: Theme.of(context).textTheme.titleLarge);
  }

  @override
  Widget build(BuildContext context) {
    return DeviceDependentConstrainedBox(
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
