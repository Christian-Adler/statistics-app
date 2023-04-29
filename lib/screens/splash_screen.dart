import 'package:flutter/material.dart';

import '../models/navigation/screen_nav_info.dart';
import '../utils/globals.dart';

class SplashScreen extends StatelessWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Splash', Icons.start, '/splash_screen');

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0, 1],
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
