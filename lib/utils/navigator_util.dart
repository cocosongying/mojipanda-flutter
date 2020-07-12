import 'package:flutter/material.dart';

class NavigatorUtil {
  static void pushPage(BuildContext context, Widget page,
      {String pageName, bool needLogin = false}) {
    if (context == null || page == null) {
      return;
    }
    // if (needLogin && !Util.isLogin()) {
    //   pushPage(context, UserLoginPage());
    //   return;
    // }
    Navigator.push(
        context, new MaterialPageRoute<void>(builder: (ctx) => page));
  }
}
