import 'package:flutter/material.dart';
import 'package:mojipanda/models/card_model.dart';
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
