import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_layout.dart';
import 'settings_card.dart';

class AppLayoutSettingsCard extends StatefulWidget {
  const AppLayoutSettingsCard({Key? key}) : super(key: key);

  @override
  State<AppLayoutSettingsCard> createState() => _AppLayoutSettingsCardState();
}

class _AppLayoutSettingsCardState extends State<AppLayoutSettingsCard> {
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
            Text('App Layout', style: Theme.of(context).textTheme.titleLarge),
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
            firstChild: const _AppLayoutSettings(),
            secondChild: Container(
              height: 0,
            ),
          ),
        ]);
  }
}

class _AppLayoutSettings extends StatelessWidget {
  const _AppLayoutSettings();

  @override
  Widget build(BuildContext context) {
    final appLayout = Provider.of<AppLayout>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 10),
        ListTile(
          leading: Checkbox(
            value: appLayout.showNavigationItemTitle,
            onChanged: (bool? value) {
              appLayout.showNavigationItemTitle = value!;
            },
          ),
          title: const Text('Text in Navigation anzeigen (Tablet)'),
        )
      ],
    );
  }
}