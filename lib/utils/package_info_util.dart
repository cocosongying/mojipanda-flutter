import 'package:package_info/package_info.dart';

class PackageInfoUtil {
  static PackageInfo packageInfo;

  static init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  static dynamic getVersion() {
    return packageInfo.version.toString();
  }

  static dynamic getAppName() {
    return packageInfo.appName.toString();
  }

  static dynamic getPackageName() {
    return packageInfo.packageName.toString();
  }

  static dynamic getBuildNumber() {
    return packageInfo.buildNumber.toString();
  }
}
