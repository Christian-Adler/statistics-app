import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../models/navigation/screen_nav_info.dart';
import '../utils/global_keys.dart';
import '../utils/hide_bottom_navigation_bar.dart';
import '../widgets/layout/single_child_scroll_view_with_scrollbar.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/responsive/screen_layout_builder.dart';
import '../widgets/settings/app_language_settings_card.dart';
import '../widgets/settings/app_layout_settings_card.dart';
import '../widgets/settings/app_theme_settings_card.dart';
import '../widgets/settings/device_storage_card.dart';
import '../widgets/settings/server_card.dart';
import '../widgets/statistics_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleSettings,
    Icons.settings,
    '/settings_screen',
    () => const SettingsScreen(),
    screensNestedNavigatorKey: GlobalKeys.settingsScreenNavigatorKey,
  );

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      createNestedNavigatorWithKey: SettingsScreen.screenNavInfo.screensNestedNavigatorKey,
      appBarBuilder: (ctx) => StatisticsAppBar(
        Text(SettingsScreen.screenNavInfo.titleBuilder(ctx)),
        ctx,
      ),
      bodyBuilder: (ctx) => const _SettingsScreenBody(),
      drawerBuilder: (ctx) => const AppDrawer(),
    );
  }
}

class _SettingsScreenBody extends StatelessWidget {
  const _SettingsScreenBody();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: SingleChildScrollViewWithScrollbar(
        scrollDirectionCallback: HideBottomNavigationBar.setScrollDirection,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppLanguageSettingsCard(),
            AppThemeSettingsCard(),
            AppLayoutSettingsCard(),
            ServerCard(),
            DeviceStorageCard(),
            // AnimationTestCard(),
          ],
        ),
      ),
    );
  }
}
