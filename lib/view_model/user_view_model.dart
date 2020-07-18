import 'package:mojipanda/common/storage_manager.dart';
import 'package:mojipanda/models/userinfo_model.dart';
import 'package:mojipanda/provider/view_state_model.dart';

class UserViewModel extends ViewStateModel {
  static const String kUser = 'kUser';

  // final GlobalFavouriteStateModel globalFavouriteStateModel;

  UserInfoModel _user;
  UserInfoModel get user => _user;
  bool get hasUser => user != null;

  UserViewModel() {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _user = userMap != null ? UserInfoModel.fromJson(userMap) : null;
  }

  saveUser(UserInfoModel user) {
    _user = user;
    notifyListeners();
    StorageManager.localStorage.setItem(kUser, user);
  }

  clearUser() {
    _user = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(kUser);
  }
}
