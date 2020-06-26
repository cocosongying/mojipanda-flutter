import 'package:fluro/fluro.dart';
import 'handler.dart';

class FluroRouter {
  static String root = '/';
  static String home = '/main';
  static Router router;

  static Router initRouter() {
    FluroRouter.router = Router();
    router.define(root, handler: mainHandler);
    router.define(home, handler: mainHandler);
    return router;
  }
}