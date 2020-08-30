import 'package:mojipanda/common/storage_manager.dart';
import 'package:mojipanda/models/userinfo_model.dart';
import 'package:mojipanda/provider/view_state_model.dart';
import 'package:mojipanda/utils/crypto_util.dart';
import 'package:mojipanda/utils/data_util.dart';
import 'package:mojipanda/view_model/user_view_model.dart';

const String kLoginName = 'kLoginName';
const String kToken = 'kToken';

class LoginViewModel extends ViewStateModel {
  final UserViewModel userModel;
  LoginViewModel(this.userModel) : assert(userModel != null);

  String getLoginName() {
    return StorageManager.sharedPreferences.getString(kLoginName);
  }

  Future<bool> login(username, password) async {
    setBusy();
    Map<String, String> params = {
      'username': username,
      'password': CryptoUtil.sha1Digest(password),
    };
    UserInfoModel userInfo = await DataUtil.login(params);
    if (userInfo != null) {
      userModel.saveUser(userInfo);
      StorageManager.sharedPreferences
          .setString(kLoginName, userModel.user.userInfo.username);
      StorageManager.sharedPreferences.setString(kToken, userModel.user.token);
      setIdle();
      return true;
    }
    return false;
  }

  Future<bool> logout() async {
    if (!userModel.hasUser) {
      return false;
    }
    setBusy();
    userModel.clearUser();
    setIdle();
    return true;
  }
}
