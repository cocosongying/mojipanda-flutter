import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SettingPageState();
  }
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('我的'),
      ),
      body: new Center(
        child: Icon(
          Icons.mood,
          size: 120.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}
