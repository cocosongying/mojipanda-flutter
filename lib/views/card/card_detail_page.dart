import 'package:flutter/material.dart';
import 'package:mojipanda/common/router_manager.dart';
import 'package:mojipanda/models/card_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CardDetailPage extends StatefulWidget {
  final CardModel card;
  CardDetailPage({this.card});

  _CardDetailPageState createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.card.title,
          style: TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry<int>>[
              PopupMenuItem(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text('编辑'),
                  ],
                ),
                value: 0,
              ),
              PopupMenuItem(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text('删除'),
                  ],
                ),
                value: 1,
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 0:
                  Navigator.of(context)
                      .pushNamed(RouteName.cardEdit, arguments: widget.card);
                  break;
                case 1:
                  showToast("点击了删除");
                  break;
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Card(
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                ListTile(
                  title: Text(
                    widget.card.number,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: QrImage(
                    data: widget.card.number,
                    size: 200.0,
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
