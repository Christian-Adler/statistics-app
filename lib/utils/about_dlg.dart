import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:intl/intl.dart';

import 'globals.dart';

class AboutDlg {
  static void showAboutDlg(BuildContext context) {
    showAboutDialog(
        context: context,
        applicationVersion: AppInfo.version,
        applicationIcon: SizedBox(
          height: 40,
          width: 40,
          child: Image.asset(
            Globals.assetImgBackground,
            fit: BoxFit.cover,
          ),
        ),
        applicationName: AppInfo.appName,
        applicationLegalese: '${DateFormat('yyyy').format(DateTime.now())} \u00a9 Christian Adler ');
  }
}
