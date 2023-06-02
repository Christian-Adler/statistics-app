import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/dynamic_theme_data.dart';
import 'settings_card.dart';

class AppThemeSettingsCard extends StatefulWidget {
  const AppThemeSettingsCard({Key? key}) : super(key: key);

  @override
  State<AppThemeSettingsCard> createState() => _AppThemeSettingsCardState();
}

class _AppThemeSettingsCardState extends State<AppThemeSettingsCard> {
  var _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('App Theme', style: Theme.of(context).textTheme.titleLarge),
            IconButton(
              onPressed: () => _toggleExpanded(),
              icon: Icon(_expanded ? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined,
                  color: Theme.of(context).colorScheme.primary),
              visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
            ),
          ],
        ),
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: const _AppThemeSettings(),
            secondChild: Container(
              height: 0,
            ),
          ),
        ]);
  }
}

class _AppThemeSettings extends StatelessWidget {
  const _AppThemeSettings();

  @override
  Widget build(BuildContext context) {
    final dynamicThemeData = Provider.of<DynamicThemeData>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 10),
        SwitchListTile(
          value: dynamicThemeData.darkMode,
          onChanged: (bool value) {
            dynamicThemeData.darkMode = value;
          },
          title: const Text('Dark Mode'),
        ),
        Row(
          children: [
            const Text('Theme setzen'),
            IconButton(
              icon: const Icon(
                Icons.color_lens_rounded,
                color: Colors.purple,
              ),
              onPressed: () {
                final dynamicThemeData = Provider.of<DynamicThemeData>(context, listen: false);
                // dynamicThemeData.primaryColor = Colors.purple;
                dynamicThemeData.setPurpleTheme();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.color_lens_rounded,
                color: Color(0xff00a8aa),
              ),
              onPressed: () {
                final dynamicThemeData = Provider.of<DynamicThemeData>(context, listen: false);
                // dynamicThemeData.primaryColor = Colors.blue;
                dynamicThemeData.setBlueTheme();
              },
            ),
          ],
        ),
      ],
    );
  }
}
