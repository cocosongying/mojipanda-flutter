import 'dart:async';

import 'package:package_info/package_info.dart';

export 'dart:io';

class PlatformUtils {
  static Future<PackageInfo> getAppPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> getBuildNum() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }
}
