import 'package:flutter/material.dart';
import 'package:mojipanda/models/chapter_model.dart';

class NovelReaderPage extends StatefulWidget {
  @override
  _NovelReaderPageState createState() => _NovelReaderPageState();
}

class _NovelReaderPageState extends State<NovelReaderPage> with RouteAware {
  List<Chapter> chapters = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _lastPressed;

  @override
  void initState() {
    // TODO: implement initState
    Chapter c1 = Chapter(1, '第一章');
    Chapter c2 = Chapter(2, '第二章');
    chapters.add(c1);
    chapters.add(c2);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didPop() {
    // TODO: implement didPop
    super.didPop();
  }

  Widget buildMenuItem(int index) {
    return Container(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          //
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 16, 15, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  "${index + 1}.  ",
                  style: TextStyle(
                    fontSize: 9,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  chapters[index].title,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.black,
          ),
          Container(
            height: 50,
            child: GestureDetector(
              onTap: () {
                //
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('目录'),
                  SizedBox(
                    width: 4,
                  ),
                ],
              ),
            ),
          ),

          /// 目录列表
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return buildMenuItem(index);
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Divider(
                          height: 1, color: Theme.of(context).dividerColor),
                    );
                  },
                  itemCount: chapters.length)),
        ],
      ),
    );
  }

  void closeSetting() {
    setState(() {
      //
    });
  }

  Widget buildSetting() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        AnimatedContainer(
          height: 15,
          duration: Duration(milliseconds: 3000),
          child: Container(
            height: 30,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(),
              ],
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 15,
          child: AnimatedPadding(
            duration: Duration(milliseconds: 3000),
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          closeSetting();
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Icon(Icons.menu),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(),
      body: WillPopScope(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                //
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            buildSetting(),
          ],
        ),
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
      ),
      // body: AnnotatedRegion(
      //   value: SystemUiOverlayStyle.dark,
      //   child: Stack(
      //     children: <Widget>[
      //       Positioned(
      //         left: 0,
      //         top: 0,
      //         right: 0,
      //         bottom: 0,
      //         child: Image.asset(Constant.ASSETS_IMG + "read_bg.png"),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
