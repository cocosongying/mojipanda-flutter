import 'package:fluttertoast/fluttertoast.dart';
import 'package:mojipanda/models/userinfo_model.dart';
import 'package:mojipanda/models/version_model.dart';

import 'net_util.dart';
import 'package_info_util.dart';
import 'package:mojipanda/api/api.dart';

class DataUtil {
  static Future<int> checkVersion(Map<String, dynamic> params) async {
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

  static Future<UserInfoModel> login(Map<String, dynamic> params) async {
    var result = await NetUtil.post(Api.LOGIN, params);
    if (checkResult(result)) {
      UserInfoModel userInfo = UserInfoModel.fromJson(result['data']);
      return userInfo;
    }
    return null;
  }

  static bool checkResult(var result) {
    if (result != null && result['code'] == 0) {
      return true;  
    }
    FlutterToast.showToast(msg: "网络错误");
    return false;
  }
}
