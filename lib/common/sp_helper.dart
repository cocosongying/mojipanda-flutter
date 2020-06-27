import 'package:flustars/flustars.dart';
import 'common.dart';

class SpHelper {
  static void putObject<T>(String key, Object value) {
    switch (T) {
      case int:
        SpUtil.putInt(key, value);
        break;
      case double:
        SpUtil.putDouble(key, value);
        break;
      case bool:
        SpUtil.putBool(key, value);
        break;
      case String:
        SpUtil.putString(key, value);
        break;
      case List:
        SpUtil.putStringList(key, value);
        break;
      default:
        SpUtil.putObject(key, value);
        break;
    }
  }

  static String getThemeColor() {
    return SpUtil.getString(Constant.keyThemeColor,
        defValue: 'deepPurpleAccent');
  }
}