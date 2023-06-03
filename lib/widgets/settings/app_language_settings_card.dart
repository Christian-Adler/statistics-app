import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/i18n/app_language.dart';
import '../../providers/app_locale.dart';
import 'settings_card.dart';

class AppLanguageSettingsCard extends StatefulWidget {
  const AppLanguageSettingsCard({Key? key}) : super(key: key);

  @override
  State<AppLanguageSettingsCard> createState() => _AppLanguageSettingsCardState();
}

class _AppLanguageSettingsCardState extends State<AppLanguageSettingsCard> {
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
            Text('App Language', style: Theme.of(context).textTheme.titleLarge),
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
            firstChild: const _AppLanguageSettings(),
            secondChild: Container(
              height: 0,
            ),
          ),
        ]);
  }
}

class _AppLanguageSettings extends StatelessWidget {
  const _AppLanguageSettings();

  @override
  Widget build(BuildContext context) {
    final appLocale = Provider.of<AppLocale>(context);
    final appLanguage = appLocale.appLanguage;

    var themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 10),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text('Sprache wählen', style: themeData.textTheme.titleMedium),
            ),
            DropdownButton<AppLanguage>(
              icon: Icon(
                Icons.arrow_drop_down_outlined,
                color: themeData.colorScheme.primary,
              ),
              underline: Container(
                height: 0,
              ),
              value: appLanguage,
              items: AppLanguage.languages().map<DropdownMenuItem<AppLanguage>>((appLang) {
                BoxDecoration? boxDeco;
                if (appLang == appLanguage) {
                  boxDeco = BoxDecoration(border: Border(bottom: BorderSide(color: themeData.colorScheme.primary)));
                }
                return DropdownMenuItem(
                    value: appLang,
                    child: Container(
                        decoration: boxDeco,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(appLang.getI18nName(context)),
                        )));
              }).toList(),
              onChanged: (value) => appLocale.appLanguage = value,
            )
          ],
        ),
      ],
    );
  }
}
