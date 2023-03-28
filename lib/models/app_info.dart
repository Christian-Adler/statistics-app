import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static String _appName = 'Not initialized';
  static String _packageName = 'Not initialized';
  static String _version = '-1,-1,-1';
  static String _buildNumber = '-1';


  static init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _appName = packageInfo.appName;
    _packageName = packageInfo.packageName;
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
  }

  static String get appName => _appName;

  static String get packageName => _packageName;

  static String get version => _version;

  static String get buildNumber => _buildNumber;
}
