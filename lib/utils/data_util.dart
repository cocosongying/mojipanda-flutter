import 'package:fluttertoast/fluttertoast.dart';
import 'package:mojipanda/models/version_model.dart';

import 'net_util.dart';
import 'package_info_util.dart';
import 'package:mojipanda/api/api.dart';

class DataUtil {
  static Future<int> checkVersion(Map<String, String> params) async {
    var result = await NetUtil.get(Api.VERSION, params);
    if (checkResult(result)) {
      VersionModel version = VersionModel.fromJson(result['data']);
      var currentVersion = version.version;
      var localVersion = PackageInfoUtil.getVersion();
      if (currentVersion.compareTo(localVersion) == 1) {
        return 1;
      }
      return 0;
    }
    return -1;
  }

  static bool checkResult(var result) {
    if (result != null && result['code'] == 0) {
      return true;  
    }
    FlutterToast.showToast(msg: "网络错误");
    return false;
  }
}
