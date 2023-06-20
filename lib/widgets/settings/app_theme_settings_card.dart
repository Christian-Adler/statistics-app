import 'package:flutter/material.dart';
import 'package:flutter_commons/widgets/card/expandable_settings_card.dart';
import 'package:flutter_commons/widgets/text/overflow_text.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../models/theme/app_theme.dart';
import '../../providers/dynamic_theme_data.dart';

class AppThemeSettingsCard extends StatelessWidget {
  const AppThemeSettingsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableSettingsCard(
      title: OverflowText(S.of(context).settingsThemeTitle, style: Theme.of(context).textTheme.titleLarge),
      content: const _AppThemeSettings(),
    );
  }
}

class _AppThemeSettings extends StatelessWidget {
  const _AppThemeSettings();

  @override
  Widget build(BuildContext context) {
    final dynamicThemeData = Provider.of<DynamicThemeData>(context);
    final appTheme = dynamicThemeData.mode;

    var themeData = Theme.of(context);
    var activeColorBorder = Border(bottom: BorderSide(color: themeData.colorScheme.primary, width: 1));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 10),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SizedBox(
                  width: 100,
                  child: Text(S.of(context).settingsThemeLabelChooseMode, style: themeData.textTheme.titleMedium)),
            ),
            DropdownButton<AppTheme>(
              icon: Icon(
                Icons.arrow_drop_down_outlined,
                color: themeData.colorScheme.primary,
              ),
              underline: Container(
                height: 2.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: themeData.colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              value: appTheme,
              items: AppTheme.modes().map<DropdownMenuItem<AppTheme>>((theme) {
                BoxDecoration? boxDeco;
                if (theme == appTheme) {
                  boxDeco = BoxDecoration(border: Border(bottom: BorderSide(color: themeData.colorScheme.primary)));
                }
                return DropdownMenuItem(
                    value: theme,
                    child: Container(
                        decoration: boxDeco,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(theme.getI18nName(context)),
                        )));
              }).toList(),
              onChanged: (value) => dynamicThemeData.mode = value,
            )
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SizedBox(
                width: 100,
                child: Text(
                  S.of(context).settingsThemeLabelChooseMainColor,
                  style: themeData.textTheme.titleMedium,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(border: dynamicThemeData.usePurpleTheme ? activeColorBorder : null),
              child: IconButton(
                icon: Icon(
                  Icons.color_lens_rounded,
                  color: Colors.purple.shade700,
                ),
                onPressed: () {
                  final dynamicThemeData = Provider.of<DynamicThemeData>(context, listen: false);
                  dynamicThemeData.setPurpleTheme();
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(border: dynamicThemeData.usePurpleTheme ? null : activeColorBorder),
              child: IconButton.outlined(
                // outlined geht nur mit useMaterial3:true :(
                icon: const Icon(
                  Icons.color_lens_rounded,
                  color: Color(0xff00a8aa),
                ),
                onPressed: () {
                  final dynamicThemeData = Provider.of<DynamicThemeData>(context, listen: false);
                  dynamicThemeData.setBlueTheme();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
