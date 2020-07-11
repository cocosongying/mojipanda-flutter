import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/models/home_card_model.dart';
import 'package:mojipanda/routers/routers.dart';

class HomeCard extends StatefulWidget {
  final HomeCardModel model;
  HomeCard({Key key, this.model}) : super(key: key);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.model.type == 1
            ? FluroRouter.router.navigateTo(
                context,
                '${FluroRouter.webViewPage}?title=${Uri.encodeComponent(widget.model.label)}&url=${Uri.encodeComponent(widget.model.url)}',
                transition: TransitionType.fadeIn,
              )
            : print('navigate to some page');
      },
      child: Card(
        color: Colors.blue,
        elevation: 20.0,
        margin:
            EdgeInsets.only(top: 16.0, right: 32.0, left: 32.0, bottom: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text(
                widget.model.title,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              ),
            ),
            new Divider(
              color: Colors.white,
            ),
            ListTile(
              subtitle: Text(
                widget.model.content,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
