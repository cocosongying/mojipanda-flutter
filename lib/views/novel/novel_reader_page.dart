import 'package:flutter/material.dart';
import 'package:mojipanda/common/common.dart';
import 'package:mojipanda/models/chapter_model.dart';

class NovelReaderPage extends StatefulWidget {
  @override
  _NovelReaderPageState createState() => _NovelReaderPageState();
}

class _NovelReaderPageState extends State<NovelReaderPage> with RouteAware {
  List<Chapter> chapters = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _lastPressed;
  static final double _addBookshelfWidth = 95;
  static final double _bottomHeight = 200;
  static final double _sImagePadding = 20;
  double _height = 0;
  double _bottomPadding = _bottomHeight;
  double _imagePadding = _sImagePadding;
  double _addBookshelfPadding = _addBookshelfWidth;
  int _duration = 200;
  double _spaceValue = 1.8;
  double _textSizeValue = 18;
  ScrollController _controller;

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
      _bottomPadding = _bottomHeight;
      _height = 0;
      _imagePadding = _sImagePadding;
      _addBookshelfPadding = _addBookshelfWidth;
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
          height: _height,
          duration: Duration(milliseconds: _duration),
          child: Container(
            height: 48,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      //
                    },
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Icon(Icons.share)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        SizedBox(
          height: 20,
        ),
        AnimatedContainer(
          height: _bottomHeight,
          duration: Duration(milliseconds: _duration),
          padding: EdgeInsets.fromLTRB(0, _bottomPadding, 0, 0),
          child: Container(
            height: _bottomHeight,
            padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 44,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "字号",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Icon(Icons.title),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            trackHeight: 2.5,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 8),
                          ),
                          child: Slider(
                            value: _textSizeValue,
                            label: "字号：$_textSizeValue",
                            divisions: 20,
                            min: 10,
                            max: 30,
                            onChanged: (double value) {
                              setState(() {
                                _textSizeValue = value;
                              });
                            },
                            onChangeEnd: (value) {
                              // _spSetTextSizeValue(value);
                            },
                          ),
                        ),
                      ),
                      Icon(Icons.title),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "间距",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Icon(Icons.format_size),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            trackHeight: 2.5,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 8),
                          ),
                          child: Slider(
                            value: _spaceValue,
                            label: "字间距：$_spaceValue",
                            min: 1.0,
                            divisions: 20,
                            max: 3.0,
                            onChanged: (double value) {
                              setState(() {
                                _spaceValue = value;
                              });
                            },
                            onChangeEnd: (value) {
                              // _spSetSpaceValue(value);
                            },
                          ),
                        ),
                      ),
                      Icon(Icons.format_size),
                    ],
                  ),
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
        // ),
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
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Image.asset(Constant.ASSETS_IMG + 'read_bg.png',
                    fit: BoxFit.cover)),
            GestureDetector(
              onTap: () {
                setState(() {
                  _bottomPadding == 0
                      ? _bottomPadding = _bottomHeight
                      : _bottomPadding = 0;
                  _height == 48 ? _height = 0 : _height = 48;
                  _imagePadding == 0
                      ? _imagePadding = _sImagePadding
                      : _imagePadding = 0;
                  _addBookshelfPadding == 0
                      ? _addBookshelfPadding = _addBookshelfWidth
                      : _addBookshelfPadding = 0;
                });
              },
              child: SingleChildScrollView(
                controller: _controller,
                padding: EdgeInsets.fromLTRB(
                  16,
                  16 + MediaQuery.of(context).padding.top,
                  9,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('title'),
                    SizedBox(
                      height: 16,
                    ),
                    // Text('content------------'),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              style: TextStyle(fontSize: 25),
                              text:
                                  'content=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjhcontent=-----=adhjadah\n\ngjh\ngad\njhscg\najhgdcjag\ndasdsadadjh'),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MaterialButton(
                          minWidth: 125,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(125)),
                            side: BorderSide(width: 1),
                          ),
                          onPressed: () {
                            //
                          },
                          child: Text("上一章"),
                        ),
                        MaterialButton(
                          minWidth: 125,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(125)),
                            side: BorderSide(width: 1),
                          ),
                          onPressed: () {
                            //
                          },
                          child: Text("下一章"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
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
    );
  }
}
