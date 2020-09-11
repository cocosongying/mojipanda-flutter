class Api {
  static const String WEBSOCKET_URL = 'ws://192.168.3.87:5001';
  static const String BASE_URL = 'https://mojipanda.com/';
  static const String BASE_API_URL = BASE_URL + 'api/';
  static const String BASE_ASSET_URL = BASE_URL + 'public/download/';

  static const String VERSION = BASE_API_URL + "app/getVersion?name=mp-apk";
  static const String CHECK_VERSION = BASE_API_URL + "app/checkVersion";
  static const String LOGIN = BASE_API_URL + "user/login";

  static const String BLOG_CATEGORY = BASE_API_URL + "blog/category";
  static const String BLOG_LIST = BASE_API_URL + "blog/list";

  static const String MZITU_LIST = BASE_API_URL + "mzitu/list";
  static const String MZITU_GRID = BASE_API_URL + "mzitu/grid";
}
