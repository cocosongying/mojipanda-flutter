import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class CardEditPage extends StatefulWidget {
  _CardEditPageState createState() => _CardEditPageState();
}

class _CardEditPageState extends State<CardEditPage> {
  final _titleController = TextEditingController();
  final _numberController = TextEditingController();

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
        child: ListView(
          children: <Widget>[
            Card(
              // color: Colors.blueAccent,
              elevation: 20.0,
              margin: EdgeInsets.only(
                  top: 64.0, right: 32.0, left: 32.0, bottom: 32.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              clipBehavior: Clip.antiAlias,
              semanticContainer: false,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: '请输入卡名',
                      ),
                    ),
                    TextField(
                      controller: _numberController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: '请输入卡号',
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CupertinoButton(child: Text('提交'), onPressed: _submitCard),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitCard() {
    var title = _titleController.text;
    var number = _numberController.text;
    showToast(title + number);
  }
}
