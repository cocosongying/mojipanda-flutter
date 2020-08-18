import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mojipanda/common/router_manager.dart';
import 'package:mojipanda/models/card_model.dart';
import 'package:oktoast/oktoast.dart';

class CardListPage extends StatefulWidget {
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  List<CardModel> cardList = [];

  @override
  void initState() {
    CardModel card = CardModel("测试", "123456");
    cardList.add(card);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.cardDetail,
                  arguments: CardModel("测试", "123456"));
            },
            child: Card(
                color: Colors.blueAccent,
                elevation: 20.0,
                margin: EdgeInsets.only(
                    top: 16.0, right: 32.0, left: 32.0, bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                clipBehavior: Clip.antiAlias,
                semanticContainer: false,
                child: Container(
                  width: 200,
                  height: 150,
                  alignment: Alignment.topLeft,
                  child: ListTile(
                    title: Text(
                      "测试",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showToast('add');
        },
      ),
    );
  }
  //
}
