import 'package:flutter/material.dart';
import 'package:flutter_commons/widgets/text/overflow_text.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../models/i18n/app_language.dart';
import '../../providers/app_locale.dart';
import '../controls/card/expandable_settings_card.dart';

class AppLanguageSettingsCard extends StatelessWidget {
  const AppLanguageSettingsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableSettingsCard(
      title: OverflowText(S.of(context).settingsLanguageTitle, style: Theme.of(context).textTheme.titleLarge),
      content: const _AppLanguageSettings(),
    );
  }
}

class _AppLanguageSettings extends StatelessWidget {
  const _AppLanguageSettings();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(height: 10),
        ChooseLanguage(),
      ],
    );
  }
}

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = Provider.of<AppLocale>(context);
    final appLanguage = appLocale.appLanguage;

    final themeData = Theme.of(context);

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 24),
          child: Text(S.of(context).settingsLanguageLabelChooseLanguage, style: themeData.textTheme.titleMedium),
        ),
        DropdownButton<AppLanguage>(
          icon: Icon(
            Icons.arrow_drop_down_outlined,
            color: themeData.colorScheme.primary,
          ),
          underline: Container(
            height: 1,
            color: themeData.colorScheme.primary,
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
                      padding: const EdgeInsets.all(5.0),
                      child: Text(appLang.getI18nName(context)),
                    )));
          }).toList(),
          onChanged: (value) => appLocale.appLanguage = value,
        )
      ],
    );
  }
}
