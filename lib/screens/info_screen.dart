import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:statistics/widgets/logo/eagle_logo.dart';
import 'package:statistics/widgets/logo/exploratia_logo.dart';
import 'package:statistics/widgets/settings/settings_card.dart';

import '../utils/globals.dart';
import '../widgets/app_drawer.dart';
import '../widgets/logo/ca_logo.dart';
import '../widgets/statistics_app_bar.dart';

class InfoScreen extends StatelessWidget {
  static const routeName = '/info_screen';
  static const title = 'Info';
  static const iconData = Icons.info_outline;

  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatisticsAppBar(
        const Text(InfoScreen.title),
        context,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            SettingsCard(title: 'Info : Statistics', children: [
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
            ]),
            // AnimationTestCard(),
          ],
        ),
      ),
    );
  }
}
