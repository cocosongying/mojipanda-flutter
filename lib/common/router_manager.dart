import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mojipanda/models/blog_model.dart';
import 'package:mojipanda/models/web_model.dart';
import 'package:mojipanda/views/blog_detail_page.dart';
import 'package:mojipanda/views/card_list_page.dart';
import 'package:mojipanda/views/fun/fun_list_page.dart';
import 'package:mojipanda/views/login_page.dart';
import 'package:mojipanda/views/setting_page.dart';
import 'package:mojipanda/views/splash.dart';
import 'package:mojipanda/views/tab/tab_navigator.dart';
import 'package:mojipanda/views/web_detail_page.dart';
import 'package:mojipanda/views/web_view_page.dart';
import 'package:mojipanda/widgets/page_route_anim.dart';

class RouteName {
  static const String splash = 'splash';
  static const String tab = '/';
  static const String login = 'login';
  static const String web = 'web';
  static const String webView = 'webView';
  static const String setting = 'setting';
  static const String fun = 'fun';
  static const String blogDetail = 'blogDetail';
  static const String cardList = 'cardList';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.tab:
        return NoAnimRouteBuilder(TabNavigator());
      case RouteName.login:
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => LoginPage(),
        );
      case RouteName.blogDetail:
        var blog = settings.arguments as Blog;
        return CupertinoPageRoute(builder: (_) {
          return BlogDetailPage(
            blog: blog,
          );
        });
      case RouteName.web:
        var webModel = settings.arguments as WebModel;
        return CupertinoPageRoute(builder: (_) {
          return WebDetailPage(
            webModel: webModel,
          );
        });
      case RouteName.webView:
        var webModel = settings.arguments as WebModel;
        return CupertinoPageRoute(builder: (_) {
          return WebViewPage(
            webModel: webModel,
          );
        });
      case RouteName.setting:
        return CupertinoPageRoute(builder: (_) => SettingPage());
      case RouteName.fun:
        return CupertinoPageRoute(builder: (_) => FunListPage());
      case RouteName.cardList:
        return CupertinoPageRoute(builder: (_) => CardListPage());
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
