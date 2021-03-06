import 'package:fluttertoast/fluttertoast.dart';
import 'package:mojipanda/common/storage_manager.dart';
import 'package:mojipanda/models/app_updateInfo_model.dart';
import 'package:mojipanda/models/blog_model.dart';
import 'package:mojipanda/models/mzitu_model.dart';
import 'package:mojipanda/models/tree_model.dart';
import 'package:mojipanda/models/userinfo_model.dart';

import 'net_util.dart';
import 'package:mojipanda/api/api.dart';

const String kToken = 'kToken';

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

  static Future<AppUpdateInfo> checkUpdate(Map<String, dynamic> params) async {
    var result = await NetUtil.post(Api.CHECK_VERSION, params);
    if (checkResult(result)) {
      AppUpdateInfo appUpdateInfo = AppUpdateInfo.fromJson(result['data']);
      return appUpdateInfo;
    }
    return null;
  }

  static Future getBlogCategories() async {
    var result = await NetUtil.get(Api.BLOG_CATEGORY);
    if (checkResult(result)) {
      return result['data']
          .map<Tree>((item) => Tree.fromJsonMap(item))
          .toList();
    }
  }

  static Future getBlogList(Map<String, dynamic> params) async {
    await Future.delayed(Duration(seconds: 1));
    var result = await NetUtil.get(Api.BLOG_LIST, params);
    if (checkResult(result)) {
      return result['data']['list']
          .map<Blog>((item) => Blog.fromJsonMap(item))
          .toList();
    }
  }

  static Future getMzituList(Map<String, dynamic> params) async {
    tokenParam(params);
    var result = await NetUtil.get(Api.MZITU_LIST, params);
    if (checkResult(result)) {
      return result['data']['list']
          .map<Mzitu>((item) => Mzitu.fromJsonMap(item))
          .toList();
    }
  }

  static Future getMzituGrid(Map<String, dynamic> params) async {
    tokenParam(params);
    var result = await NetUtil.get(Api.MZITU_GRID, params);
    if (checkResult(result)) {
      return result['data']['list']
          .map<Mzitu>((item) => Mzitu.fromJsonMap(item))
          .toList();
    }
  }

  static bool checkResult(var result) {
    if (result == null || result['code'] == null) {
      FlutterToast.showToast(msg: "网络错误");
    } else {
      if (result['code'] == 0) {
        return true;
      } else if (result['code'] == 10002) {
        FlutterToast.showToast(msg: "令牌错误，请重新登录");
        throw 10002;
      }
    }
    return false;
  }

  static void tokenParam(Map<String, dynamic> params) {
    String token = StorageManager.sharedPreferences.get(kToken);
    params['token'] = token;
  }
}
