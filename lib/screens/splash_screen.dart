import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/safe_area_info.dart';
import 'package:provider/provider.dart';

import '../models/navigation/screen_nav_info.dart';
import '../providers/dynamic_theme_data.dart';
import '../utils/globals.dart';

class SplashScreen extends StatelessWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (_) => 'Splash',
    Icons.start,
    '/splash_screen',
    () => const SplashScreen(),
  );

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SafeAreaInfo.determineSafeAreaHeight(context);
    final activeThemeColors = Provider.of<DynamicThemeData>(context).getActiveThemeColors();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: activeThemeColors.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // stops: const [0, 1],
          ),
        ),
        // child: const CenteredLogo(), // sehr kurz sichtbar - daher nur auf dem SplashScreen
      ),
    );
  }
}

class CenteredLogo extends StatelessWidget {
  const CenteredLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.asset(
                      Globals.assetImgEagleLogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'Loading...',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
            ),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
