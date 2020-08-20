import 'package:flutter/material.dart';

class CardEditPage extends StatefulWidget {
  _CardEditPageState createState() => _CardEditPageState();
}

class _CardEditPageState extends State<CardEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("测试"),
            )
          ],
        ),
      ),
    );
  }
}
