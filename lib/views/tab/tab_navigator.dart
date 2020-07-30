import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/views/tab/home_page.dart';
import 'package:mojipanda/views/tab/user_page.dart';
import 'package:mojipanda/widgets/app_update_widget.dart';
import 'package:oktoast/oktoast.dart';

List<Widget> pages = <Widget>[
  HomePage(),
  UserPage(),
];

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController = PageController();
  DateTime _lastPressed;

  @override
  void initState() {
    checkAppUpdate(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: PageView.builder(
          itemBuilder: (ctx, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
        ),
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            showToast('再次点击返回键退出App', position: ToastPosition.bottom);
            return false;
          }
          return true;
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        // backgroundColor: Theme.of(context).cardColor,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black12
            : Theme.of(context).accentColor,
        color: Theme.of(context).scaffoldBackgroundColor,
        buttonBackgroundColor: Colors.black54,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.home,
            color: Theme.of(context).accentColor,
          ),
          Icon(
            Icons.account_box,
            color: Theme.of(context).accentColor,
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
