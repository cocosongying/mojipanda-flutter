import 'package:flutter/material.dart';
import 'home_page.dart';
import 'setting_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  List<Widget> _list = List();
  int _currentIndex = 0;
  List tabData = [
    {'text': '首页', 'icon': Icon(Icons.home)},
    {'text': '我的', 'icon': Icon(Icons.account_circle)},
  ];
  List<BottomNavigationBarItem> _myTabs = [];
  var _pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _list..add(HomePage())..add(SettingPage());
    for (int i = 0; i < tabData.length; i++) {
      _myTabs.add(BottomNavigationBarItem(
          icon: tabData[i]['icon'], title: Text(tabData[i]['text'])));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // body: _list[_currentIndex],
      body: new PageView.builder(
        onPageChanged: _pageChange,
        controller: _pageController,
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return _list[_currentIndex];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: _myTabs, currentIndex: _currentIndex, onTap: _itemTapped),
    );
  }

  void _pageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _itemTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
