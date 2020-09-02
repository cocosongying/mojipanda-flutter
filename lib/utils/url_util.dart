import 'package:mojipanda/api/api.dart';

class UrlUtil {
  static String getImgUrl(String url) {
    if (url.startsWith('http')) {
      return url;
    } else {
      return Api.BASE_ASSET_URL + url;
    }
  }
}