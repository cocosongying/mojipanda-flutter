import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/common/common.dart';
import 'package:mojipanda/common/router_manager.dart';
import 'package:mojipanda/models/home_card_model.dart';
import 'package:mojipanda/models/web_model.dart';

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
        // 暂时只有一个页面
        // Navigator.push(
        //   context,
        //   CupertinoPageRoute(
        //     builder: (context) =>
        //         WebViewPage(widget.model.url, widget.model.label),
        //     fullscreenDialog: true,
        //   ),
        // );
        widget.model.type == Constant.jumpTypePage
            ? Navigator.of(context).pushNamed(RouteName.fun)
            : Navigator.of(context).pushNamed(RouteName.web,
                arguments: WebModel()
                  ..title = widget.model.label
                  ..url = widget.model.url);
      },
      child: Card(
        color: Theme.of(context).cardColor,
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
                // style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                // color: Colors.white,
              ),
            ),
            new Divider(
                // color: Colors.white,
                ),
            ListTile(
              subtitle: Text(
                widget.model.content,
                // style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
