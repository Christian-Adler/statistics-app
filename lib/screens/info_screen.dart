import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:statistics/utils/about_dlg.dart';
import 'package:statistics/widgets/layout/single_child_scroll_view_with_scrollbar.dart';

import '../models/app_info.dart';
import '../models/navigation/screen_nav_info.dart';
import '../utils/globals.dart';
import '../widgets/logo/ca_logo.dart';
import '../widgets/logo/eagle_logo.dart';
import '../widgets/logo/exploratia_logo.dart';
import '../widgets/navigation/app_bottom_navigation_bar.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/responsive/screen_layout_builder.dart';
import '../widgets/settings/settings_card.dart';
import '../widgets/statistics_app_bar.dart';

class InfoScreen extends StatelessWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    'Info',
    Icons.info_outline,
    '/info_screen',
    () => const InfoScreen(),
  );

  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutBuilder(
      appBar: StatisticsAppBar(
        Text(InfoScreen.screenNavInfo.title),
        context,
      ),
      body: const _InfoScreenBody(),
      drawerBuilder: () => const AppDrawer(),
      bottomNavigationBarBuilder: () => const AppBottomNavigationBar(),
    );
  }
}

class _InfoScreenBody extends StatelessWidget {
  const _InfoScreenBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollViewWithScrollbar(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
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
                label: const Text('App info')),
          )
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
            child: Image.asset(
              Globals.assetImgCaLogo,
              fit: BoxFit.cover,
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
            child: Image.asset(
              Globals.assetImgExploratiaLogo,
              fit: BoxFit.cover,
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
            child: Image.asset(
              Globals.assetImgEagleLogo,
              fit: BoxFit.cover,
            ),
          ),
          const Text(' https://www.adlers-online.de'),
        ],
      ),
    ]);
  }
}
