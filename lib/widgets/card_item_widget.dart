import 'package:flutter/material.dart';
import 'package:mojipanda/models/card_model.dart';

class CardItem extends StatefulWidget {
  final CardModel card;
  CardItem({this.card});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 152.0,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 22.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: Theme.of(context).brightness == Brightness.dark
              ? null
              : [
                  BoxShadow(
                      color: const Color(0x805793FA),
                      offset: Offset(0.0, 2.0),
                      blurRadius: 8.0,
                      spreadRadius: 0.0),
                ],
          gradient: LinearGradient(
              colors: const [Color(0xFF40E6AE), Color(0xFF2DE062)]),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 25.0,
              left: 24.0,
              child: Container(
                height: 40.0,
                width: 40.0,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Icon(Icons.credit_card),
              ),
            ),
            Positioned(
              top: 22.0,
              left: 72.0,
              child: Text(
                widget.card.title,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            Positioned(
              top: 48.0,
              left: 72.0,
              child: Text(
                "会员卡",
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            ),
            Positioned(
              bottom: 24.0,
              left: 72.0,
              child: Text(
                widget.card.number,
                style: TextStyle(
                    color: Colors.white, fontSize: 18.0, letterSpacing: 1.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  //
}
