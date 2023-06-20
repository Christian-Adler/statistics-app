import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_commons/utils/hide_bottom_navigation_bar.dart';
import 'package:flutter_commons/utils/nav/navigator_transition_builder.dart';
import 'package:flutter_commons/widgets/card/settings_card.dart';
import 'package:flutter_commons/widgets/layout/single_child_scroll_view_with_scrollbar.dart';
import 'package:flutter_commons/widgets/responsive/screen_layout_builder.dart';
import 'package:flutter_simple_logging/daily_files.dart';
import 'package:intl/intl.dart';

import '../generated/l10n.dart';
import '../models/navigation/screen_nav_info.dart';
import '../utils/about_dlg.dart';
import '../utils/globals.dart';
import '../widgets/logo/ca_logo.dart';
import '../widgets/logo/eagle_logo.dart';
import '../widgets/logo/exploratia_logo.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/statistics_app_bar.dart';
import 'logs_screen.dart';

class InfoScreen extends StatelessWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => S.of(ctx).screenTitleInfo,
    Icons.info_outline,
    '/info_screen',
    () => const InfoScreen(),
  );

  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      createNestedNavigatorWithKey: InfoScreen.screenNavInfo.screensNestedNavigatorKey,
      appBarBuilder: (ctx) => StatisticsAppBar(
        Text(InfoScreen.screenNavInfo.titleBuilder(ctx)),
        ctx,
      ),
      bodyBuilder: (ctx) => const _InfoScreenBody(),
      drawerBuilder: (ctx) => const AppDrawer(),
    );
  }
}

class _InfoScreenBody extends StatelessWidget {
  const _InfoScreenBody();

  @override
  Widget build(BuildContext context) {
    VoidCallback? showLogsHandler;
    if (DailyFiles.logsDirAvailable()) {
      showLogsHandler =
          () => Navigator.of(context).push(NavigatorTransitionBuilder.buildSlideHTransition(const LogsScreen()));
    }

    return SingleChildScrollViewWithScrollbar(
      scrollPositionHandler: HideBottomNavigationBar.setScrollPosition,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EagleLogo(),
              SizedBox(height: 10, width: 10),
              CaLogo(),
              SizedBox(height: 10, width: 10),
              ExploratiaLogo(),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 96,
            width: 96,
            child: Center(
              child: Image.asset(
                Globals.assetImgBackground,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const _AppInfoCard(),
          Center(
            child: OutlinedButton.icon(
              onPressed: () => AboutDlg.showAboutDlg(context),
              icon: const Icon(Icons.info_outline),
              label: const Text('App info'),
            ),
          ),
          Center(
            child: OutlinedButton.icon(
              onPressed: showLogsHandler,
              icon: Icon(LogsScreen.screenNavInfo.iconData),
              label: Text(LogsScreen.screenNavInfo.titleBuilder(context)),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppInfoCard extends StatelessWidget {
  const _AppInfoCard();

  @override
  Widget build(BuildContext context) {
    return SettingsCard(title: AppInfo.appName, children: [
      const Divider(height: 10),
      Row(
        children: [
          SizedBox(
            height: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                Globals.assetImgCaLogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(' ${DateFormat('yyyy').format(DateTime.now())} \u00a9 Christian Adler '),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          SizedBox(
            height: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                Globals.assetImgExploratiaLogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(' https://www.exploratia.de'),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          SizedBox(
            height: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                Globals.assetImgEagleLogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(' https://www.adlers-online.de'),
        ],
      ),
    ]);
  }
}
