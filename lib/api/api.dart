class Api {
  static const String BASE_URL = 'https://mojipanda.com/';
  static const String BASE_API_URL = BASE_URL + 'api/';

  static const String VERSION = BASE_API_URL + "app/getVersion?name=mp-apk";
  static const String CHECK_VERSION = BASE_API_URL + "app/checkVersion";
  static const String LOGIN = BASE_API_URL + "user/login";
}
