import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/models/app_updateInfo_model.dart';
import 'package:mojipanda/provider/view_state_model.dart';
import 'package:mojipanda/utils/platform_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kAppFirstEntry = 'kAppFirstEntry';

class AppViewModel with ChangeNotifier {
  bool isFirst = false;
  loadIsFirstEntry() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    isFirst = sharedPreferences.getBool(kAppFirstEntry);
    notifyListeners();
  }
}

class AppUpdateViewModel extends ViewStateModel {
  Future<AppUpdateInfo> checkUpdate() async {
    AppUpdateInfo appUpdateInfo;
    setBusy();
    try {
      var appVersion = await PlatformUtils.getAppVersion();
      print(appVersion);
      // appUpdateInfo = await AppRepository.checkUpdate(Platform.operatingSystem, appVersion);
      setIdle();
    } catch (e, s) {
      setError(e,s);
    }
    return appUpdateInfo;
  }
}
