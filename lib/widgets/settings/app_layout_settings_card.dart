import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../providers/app_layout.dart';
import 'expandable_settings_card.dart';

class AppLayoutSettingsCard extends StatelessWidget {
  const AppLayoutSettingsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableSettingsCard(
      title: Text(S.of(context).settingsLayoutTitle, style: Theme.of(context).textTheme.titleLarge),
      content: const _AppLayoutSettings(),
    );
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
        SwitchListTile(
          value: appLayout.showNavigationItemTitle,
          onChanged: (bool value) {
            appLayout.showNavigationItemTitle = value;
          },
          title: Text(S.of(context).settingsLayoutLabelShowNavigationTitles),
        ),
        SwitchListTile(
          value: appLayout.enableOverviewParallax,
          onChanged: (bool value) {
            appLayout.enableOverviewParallax = value;
          },
          title: Text(S.of(context).settingsLayoutLabelShowOverviewParallaxEffect),
        ),
        SwitchListTile(
          value: appLayout.useOverviewIsometricButtons,
          onChanged: (bool value) {
            appLayout.useOverviewIsometricButtons = value;
          },
          title: Text(S.of(context).settingsLayoutLabelShowOverviewIsometricButtons),
        ),
      ],
    );
  }
}
