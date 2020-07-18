import 'package:fluttertoast/fluttertoast.dart';
import 'package:mojipanda/models/userinfo_model.dart';

import 'net_util.dart';
import 'package:mojipanda/api/api.dart';

class DataUtil {
  static Future<UserInfoModel> login(Map<String, dynamic> params) async {
    var result = await NetUtil.post(Api.LOGIN, params);
    if (checkResult(result)) {
      UserInfoModel userInfo = UserInfoModel.fromJson(result['data']);
      return userInfo;
    }
    if (result != null && result['code'] != null) {
      FlutterToast.showToast(msg: "用户名或密码错误");
    }
    return null;
  }

  static bool checkResult(var result) {
    if (result != null && result['code'] == 0) {
      return true;
    }
    if (result == null || result['code'] == null) {
      FlutterToast.showToast(msg: "网络错误");
    }
    return false;
  }
}
