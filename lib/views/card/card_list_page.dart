import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/common/router_manager.dart';
import 'package:mojipanda/models/card_model.dart';
import 'package:mojipanda/views/card/card_edit_page.dart';
import 'package:mojipanda/widgets/card_item_widget.dart';

class CardListPage extends StatefulWidget {
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  List<CardModel> cardList = [];

  @override
  void initState() {
    CardModel card = CardModel(id: 1, title: "测试", number: "123456");
    cardList.add(card);
    super.initState();
  }

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
        child: ListView(children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.cardDetail,
                  arguments: CardModel(id: 1, title: "测试", number: "123456"));
            },
            child: CardItem(card: this.cardList[0]),
            // child: Card(
            //     color: Colors.blueAccent,
            //     elevation: 20.0,
            //     margin: EdgeInsets.only(
            //         top: 16.0, right: 32.0, left: 32.0, bottom: 16.0),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //     ),
            //     clipBehavior: Clip.antiAlias,
            //     semanticContainer: false,
            //     child: Container(
            //       width: 200,
            //       height: 150,
            //       alignment: Alignment.topLeft,
            //       child: ListTile(
            //         title: Text(
            //           "测试",
            //           style: TextStyle(fontSize: 20, color: Colors.white),
            //         ),
            //       ),
            //     )),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigator.of(context).pushNamed(RouteName.cardEdit);
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CardEditPage(
                card: CardModel(),
              ),
              fullscreenDialog: true,
            ),
          );
        },
      ),
    );
  }
  //
}
