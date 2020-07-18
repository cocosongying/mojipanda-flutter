import 'dart:io';

import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  /// 全局配置 eg:theme
  static SharedPreferences sharedPreferences;
  /// 临时目录 eg:cookie
  static Directory temporaryDirectory;
  /// 初始化操作 eg:user
  static LocalStorage localStorage;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    temporaryDirectory = await getTemporaryDirectory();
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready;
  }
}
