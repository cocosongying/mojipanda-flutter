import 'package:flutter/material.dart';

class CardEditPage extends StatefulWidget {
  _CardEditPageState createState() => _CardEditPageState();
}

class _CardEditPageState extends State<CardEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "卡包",
          style: TextStyle(fontSize: 16),
        ),
      ),
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
