import 'package:flutter/material.dart';
import 'package:mojipanda/common/component_index.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(IntlUtil.getString(context, Ids.titleHome)),
      ),
      body: new Center(
          child: Icon(
        Icons.home,
        size: 120.0,
        color: Theme.of(context).accentColor,
      )),
    );
  }
}
